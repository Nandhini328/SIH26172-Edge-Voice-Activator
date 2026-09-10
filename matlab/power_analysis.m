%% PS26172 - Power Budget Analysis
% Use measurements from a current/voltage monitor on the final hardware.
% Target is an always-listening average below 50 mW.

clc; clear; close all;

stateNames = ["Listening" "Wake detected" "Streaming"];
% Replace NaN with measured average power in mW.
power_mW = [NaN NaN NaN];

disp(table(stateNames',power_mW','VariableNames',{'State','Power_mW'}));

if all(isfinite(power_mW))
    fprintf('Listening average power: %.2f mW\n',power_mW(1));
    fprintf('Always-listening target: <50 mW\n');
else
    fprintf('Power measurements are pending. Do not present the 50 mW value as a measured result.\n');
end
