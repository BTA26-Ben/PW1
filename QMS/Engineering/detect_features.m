function features = detect_features(signal, Fs)
%DETECT_FEATURES Detect ECG waveform features
%   TODO - Simple features:
%       - Heart rate
%       - P, Q, R, S, T peak locations
%       - P, T, S, QRS durations
%       - PR, ST, QTc intervals
%       - Arrhythmia presence
%   TODO - Complex features:
%       - U wave
%       - Arrhythmia type
%       - Pacing spike
%       - Ectopic beats
%       - T wave inversion
%       - Electrical alternans

    features = struct();

    % Start with R-peak detection using findpeaks
    % TODO: tune MinPeakDistance and MinPeakHeight
    [features.R_peaks, features.R_locs] = findpeaks(signal, ...
        'MinPeakDistance', round(0.3*Fs));

    % Heart rate from RR intervals
    if length(features.R_locs) >= 2
        RR = diff(features.R_locs) / Fs;
        features.heart_rate = 60 / mean(RR);
        features.RR_intervals = RR;
    else
        features.heart_rate = NaN;
    end

    % TODO: Q, S, P, T detection
    % TODO: interval and duration calculations
    % TODO: arrhythmia checks

end
