%% PS26172 - Classification Metrics
% Calculates precision, recall and F1 from the measured confusion matrix.

clc; clear; close all;

CM = [3 0 0; 0 39 0; 1 1 38];
classNames = ["hey_kira"; "noise"; "unknown"];
numClasses = 3;

precision = zeros(numClasses,1);
recall = zeros(numClasses,1);
f1score = zeros(numClasses,1);

for i = 1:numClasses
    TP = CM(i,i);
    FP = sum(CM(:,i))-TP;
    FN = sum(CM(i,:))-TP;
    precision(i) = TP/max(TP+FP,1);
    recall(i) = TP/max(TP+FN,1);
    f1score(i) = 2*precision(i)*recall(i)/max(precision(i)+recall(i),eps);
end

accuracy = sum(diag(CM))/sum(CM,'all');

fprintf('Overall Accuracy : %.2f%%\n',accuracy*100);
for i = 1:numClasses
    fprintf('%-10s Precision = %.2f%%  Recall = %.2f%%  F1 = %.2f%%\n',...
        classNames(i),precision(i)*100,recall(i)*100,f1score(i)*100);
end

metrics = [precision*100 recall*100 f1score*100];
figure('Position',[100 100 900 550]);
bar(metrics,'grouped');
xticklabels(classNames);
ylabel('Percentage (%)');
title('MATLAB INT8 Test Performance');
legend('Precision','Recall','F1-Score','Location','southoutside',...
    'Orientation','horizontal');
ylim([0 110]); grid on;
