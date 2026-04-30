%% main_ecg_analysis.m
%  PW1 - The Puzzling Echocardiogram
%  University of Bath - EE22005
%  Main script - run this one
clear; clc; close all;
 
%% ==================== USER SETTINGS ====================
filename = 'test_signal.mat';   % change per signal
Fs = 360;                       % sampling freq (Hz) - check per dataset
 
%% ==================== LOAD SIGNAL ====================
[signal, time] = load_ecg(filename, Fs);
 
fprintf('==============================================\n');
fprintf('  ECG SIGNAL ANALYSIS - PW1\n');
fprintf('==============================================\n');
fprintf('File:              %s\n', filename);
fprintf('Sampling Freq:     %d Hz\n', Fs);
fprintf('Duration:          %.2f seconds\n', time(end));
fprintf('Samples:           %d\n', length(signal));
fprintf('==============================================\n\n');
 
%% ==================== PLOT RAW SIGNAL ====================
figure('Name', 'Raw ECG', 'Position', [100 500 900 300]);
plot(time, signal, 'b');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
title(sprintf('Raw ECG — %s', filename));
grid on;
 
%% ==================== FILTER SIGNAL ====================
filtered = filter_ecg(signal, Fs);
 
% Side-by-side comparison
figure('Name', 'Filter Comparison', 'Position', [100 100 900 500]);
 
subplot(2,1,1);
plot(time, signal, 'b');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
title('Before Filtering');
grid on;
 
subplot(2,1,2);
plot(time, filtered, 'r');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
title('After Filtering');
grid on;
 
%% ==================== DETECT FEATURES ====================
features = detect_features(filtered, Fs);
 
fprintf('---------- FEATURES ----------\n');
fprintf('Heart Rate:        %.1f bpm\n', features.heart_rate);
fprintf('R-peaks found:     %d\n', length(features.R_locs));
 
if isfield(features, 'mean_qrs_duration')
    fprintf('Mean QRS duration: %.0f ms\n', features.mean_qrs_duration * 1000);
end
if isfield(features, 'mean_pr_interval')
    fprintf('Mean PR interval:  %.0f ms\n', features.mean_pr_interval * 1000);
end
if isfield(features, 'mean_qtc_interval')
    fprintf('Mean QTc interval: %.0f ms\n', features.mean_qtc_interval * 1000);
end
if isfield(features, 'mean_st_interval')
    fprintf('Mean ST interval:  %.0f ms\n', features.mean_st_interval * 1000);
end
if isfield(features, 'irregular_rhythm')
    if features.irregular_rhythm
        fprintf('Rhythm:            IRREGULAR\n');
    else
        fprintf('Rhythm:            Regular\n');
    end
end
fprintf('------------------------------\n\n');
 
%% ==================== ANNOTATED PLOT ====================
figure('Name', 'Annotated ECG', 'Position', [100 100 1200 500]);
plot(time, filtered, 'k', 'LineWidth', 0.8); hold on;
 
% R-peaks (red triangles)
if isfield(features, 'R_locs') && ~isempty(features.R_locs)
    plot(time(features.R_locs), filtered(features.R_locs), ...
        'rv', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
end
 
% P-peaks (blue circles)
if isfield(features, 'P_locs') && ~isempty(features.P_locs)
    valid_P = features.P_locs(features.P_locs > 0);
    plot(time(valid_P), filtered(valid_P), ...
        'bo', 'MarkerSize', 7, 'MarkerFaceColor', 'b');
end
 
% Q-peaks (green squares)
if isfield(features, 'Q_locs') && ~isempty(features.Q_locs)
    valid_Q = features.Q_locs(features.Q_locs > 0);
    plot(time(valid_Q), filtered(valid_Q), ...
        'gs', 'MarkerSize', 6, 'MarkerFaceColor', 'g');
end
 
% S-peaks (magenta squares)
if isfield(features, 'S_locs') && ~isempty(features.S_locs)
    valid_S = features.S_locs(features.S_locs > 0);
    plot(time(valid_S), filtered(valid_S), ...
        'ms', 'MarkerSize', 6, 'MarkerFaceColor', 'm');
end
 
% T-peaks (cyan diamonds)
if isfield(features, 'T_locs') && ~isempty(features.T_locs)
    valid_T = features.T_locs(features.T_locs > 0);
    plot(time(valid_T), filtered(valid_T), ...
        'cd', 'MarkerSize', 7, 'MarkerFaceColor', 'c');
end
 
xlabel('Time (s)'); ylabel('Amplitude (mV)');
title(sprintf('Annotated ECG — HR: %.0f bpm', features.heart_rate));
 
% Build legend based on what was actually detected
leg = {'ECG'};
if isfield(features, 'R_locs') && ~isempty(features.R_locs), leg{end+1} = 'R'; end
if isfield(features, 'P_locs') && ~isempty(features.P_locs), leg{end+1} = 'P'; end
if isfield(features, 'Q_locs') && ~isempty(features.Q_locs), leg{end+1} = 'Q'; end
if isfield(features, 'S_locs') && ~isempty(features.S_locs), leg{end+1} = 'S'; end
if isfield(features, 'T_locs') && ~isempty(features.T_locs), leg{end+1} = 'T'; end
legend(leg, 'Location', 'northeast');
grid on; hold off;
 
%% ==================== RR INTERVAL PLOT ====================
if isfield(features, 'RR_intervals') && length(features.RR_intervals) > 1
    figure('Name', 'RR Intervals', 'Position', [100 100 700 300]);
    plot(features.RR_intervals * 1000, 'o-', 'LineWidth', 1.2);
    xlabel('Beat Number'); ylabel('RR Interval (ms)');
    title('RR Interval Variability');
    yline(mean(features.RR_intervals)*1000, '--r', ...
        sprintf('Mean: %.0f ms', mean(features.RR_intervals)*1000));
    grid on;
end
 
%% ==================== DIFFERENTIAL DIAGNOSIS ====================
diagnoses = diagnose_ecg(features);
 
fprintf('---------- DIAGNOSES ----------\n');
if isempty(diagnoses)
    fprintf('  No diagnosis generated — check feature detection.\n');
else
    for i = 1:length(diagnoses)
        fprintf('  [%d] %s\n', i, diagnoses{i});
    end
end
fprintf('-------------------------------\n');
 
%% ==================== SUMMARY ====================
fprintf('\n==============================================\n');
fprintf('  ANALYSIS COMPLETE\n');
fprintf('  Figures: Raw | Filtered | Annotated | RR\n');
fprintf('==============================================\n');
