%����ѭ��
%ÿ����29������֮���corr,�õ� 29 * 29 �� Matrix
%1. �����Ա�������֮������ϵ�������Ӧ��Pֵ��һ����Ϊ���ϵ��>0.7����P<0.05ʱ�ɿ����Ա���֮����ڹ����ԣ�������Ϊ�����ж϶��ع����Ե�һ�ַ�����
%2. ���������ͳ��������Tolerance�����̶ȣ���VIF�������������ӣ���һ����Ϊ���Tolerance<0.2��VIF>5��Tolerance��VIF�ʵ�����ϵ��������ʾҪ�����Ա���֮����ڶ��ع����Ե����⡣
function passNumber = alphaEDA(exposure, alphaName,startTime)
[m,n,p] = size(exposure);

for i = m-startTime +1:m
    matrix = exposure(i,:,:);
    reshapeAlpha = reshape(matrix,[n,p]);
    passAlpha = zeros(n,p);
    reshapeAlpha = rmmissing(reshapeAlpha,1);
    [x,y]=find(reshapeAlpha==inf);
    reshapeAlpha(unique(x),:)=[];
    corrMatrix = corr(reshapeAlpha);
    
    pic = figure(); %'visible','off'
    ezplot('0');
    h = heatmap(alphaName, alphaName, corrMatrix, 'FontSize', 10, 'FontName', 'Consolas');
    h.Title = 'Correlation Coefficients of Orthed Factors';
    colormap(jet);
    saveas(gcf,strcat('correlation_alpha_','_time_',num2str(i),'_',date,'.fig'));

    % calculate VIF matrix
    [~, q] = size(reshapeAlpha);
    VIFVector = zeros(q, 1);
    for j = 1: q
        Y = reshapeAlpha(:, j);
        X = [reshapeAlpha(:, 1: (j - 1)), reshapeAlpha(:, (j + 1): q)];
        rSquare = regstats(Y,X,'linear','rsquare');
        rSquare = rSquare.rsquare;
        VIFVector(j) = 1/(1-rSquare);
    end
    VIFJudge(:,1) = VIFVector<5;
    passNumber(i,:) = VIFJudge';
end
end