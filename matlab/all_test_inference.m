%% PS26172 - Complete MATLAB INT8 Test Inference
% Runs the exported INT8 TFLite model over the 82-sample test set.
% Update DATA_DIR if your local files are stored elsewhere.

clc; clear; close all;

DATA_DIR = "../data";
MODEL_FILE = fullfile(DATA_DIR,"model_int8.lite");
X_FILE = fullfile(DATA_DIR,"X_testing.mat");
Y_FILE = fullfile(DATA_DIR,"y_testing.mat");

load(X_FILE,"X");
load(Y_FILE,"y");
net = loadTFLiteModel(MODEL_FILE);

classNames = ["hey_kira"; "noise"; "unknown"];
numSamples = size(X,1);
predictedLabels = zeros(numSamples,1);
outputScores = zeros(numSamples,3);

fprintf("Running %d test samples...\n\n",numSamples);

for i = 1:numSamples
    sample = X(i,:)';

    % Edge Impulse MFE export is normalized approximately to [0,1].
    % Convert to the signed INT8 range expected by this exported model.
    sample_int8 = int8(round(sample * 255 - 128));

    output = predict(net,sample_int8, ...
        DequantizeOutputs=false, ...
        EnableINT8InferenceOnWindows=true);

    output = double(output(:));
    outputScores(i,:) = output';
    [~,predictedIndex] = max(output);
    predictedLabels(i) = predictedIndex;

    fprintf("Sample %2d : %-8s\n",i,classNames(predictedIndex));
end

trueLabels = double(y(:,1));
correct = predictedLabels == trueLabels;
accuracy = mean(correct)*100;

fprintf("\n============================================\n");
fprintf("MATLAB INT8 TEST RESULTS\n");
fprintf("============================================\n");
fprintf("Total samples : %d\n",numSamples);
fprintf("Correct       : %d\n",sum(correct));
fprintf("Incorrect     : %d\n",sum(~correct));
fprintf("Accuracy      : %.2f %%\n",accuracy);

CM = confusionmat(trueLabels,predictedLabels);
disp("Confusion Matrix:");
disp(CM);

figure('Position',[100 100 850 600]);
confusionchart(...
    categorical(trueLabels,1:3,classNames), ...
    categorical(predictedLabels,1:3,classNames));
title("MATLAB INT8 Test Confusion Matrix");
xlabel("Predicted Class");
ylabel("True Class");

% Save numeric results for later latency/statistical analysis.
save(fullfile(DATA_DIR,"matlab_test_results.mat"), ...
    "trueLabels","predictedLabels","outputScores","CM","accuracy");
