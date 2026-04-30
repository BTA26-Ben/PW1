%% main_ecg_analysis.m
%  PW1 - The Puzzling Echocardiogram
%  Main script - run this one
clear; clc; close all;

%% Settings
filename = 'test_signal.mat';   % change per signal
Fs = 360;                       % sampling freq (Hz) - check per dataset

%% Load signal
[signal, time] = load_ecg(filename, Fs);

%% Plot raw signal
figure;
plot(time, signal);
xlabel('Time (s)'); ylabel('Amplitude');
title('Raw ECG');
grid on;

%% Filter signal
% TODO: call filter function once written
% filtered = filter_ecg(signal, Fs);

%% Detect features
% TODO: call feature detection once written
% features = detect_features(filtered, Fs);

%% Diagnose
% TODO: call diagnosis once written
% diagnoses = diagnose_ecg(features);
