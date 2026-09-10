%% PS26172 - Latency Budget Analysis
% Use measured stage timings from the ESP32-S3 when hardware is available.
% This script is a template: replace NaN values with measured milliseconds.

clc; clear; close all;

stageNames = ["Audio window" "Fast rejection" "Feature extraction" ...
    "INT8 inference" "Confidence/debounce" "Decision" ];

% Replace these NaN values with measured ESP32-S3 timings.
stage_ms = [NaN NaN NaN NaN NaN NaN];

disp(table(stageNames',stage_ms','VariableNames',{'Stage','Latency_ms'}));

if all(isfinite(stage_ms))
    total_ms = sum(stage_ms);
    fprintf('Total measured wake-word pipeline latency: %.3f ms\n',total_ms);
    fprintf('Target: <100 ms\n');
else
    fprintf('Hardware timings are pending. Do not report a measured latency until ESP32-S3 timing data is collected.\n');
end
