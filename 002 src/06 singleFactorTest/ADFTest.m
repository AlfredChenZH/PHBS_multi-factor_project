function stationarity = ADFTest(m)
[H,pValue]=adftest(abs(m));
if pValue < 0.05                   %reject H0, ��Ϊԭ������ƽ�ȵ�
     stationarity =1;
else stationarity =0;
end
