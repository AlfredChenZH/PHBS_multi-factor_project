function [normFactor, meanValue, medianValue, skewnessValue, kurtosisValue] = normalizeProcess(factorMatrix, date)
% NORMALIZEPROCESS returns the normalized version of feedStruct with
% z-score method and the statistical figures and histogram of the factors
% The normalization will be cross-sectional, which means row-wise
% x_i = (x_i - mean(x_i))/std(x_i)

    normFactor = factorMatrix;
    normFactor = zscore(normFactor, 0, 2);
    meanValue = mean(normFactor, 2);
    medianValue = median(normFactor, 2);
    skewnessValue = skewness(normFactor, 1, 2);
    kurtosisValue = kurtosis(normFactor, 1, 2);
    
    % draw and save histogram
    [m, ~] = size(normFactor);
    h = figure;
    histogram(normFactor(m, :));
    filename = num2str(date) + ".fig";
    savefig(h, filename)
end

% function normFactor = normalizeProcess(factorMatrix)
% % NORMALIZEPROCESS returns the normalized version of feedStruct with
% % z-score method 
% % The normalization will be cross-sectional, which means row-wise
% % x_i = (x_i - mean(x_i))/std(x_i)
% % check validity of input: fieldName
% 
%     normFactor = factorMatrix;
%     normFactor = zscore(normFactor, 0, 2);
% %     meanValue = mean(normFactor, 2);
% %     medianValue = median(normFactor, 2);
% %     skewnessValue = skewness(normFactor, 1, 2);
% %     kurtosisValue = kurtosis(normFactor, 1, 2);
% %     [m, ~] = size(normFactor);
% %     histogram(normFactor(m, :));
% end