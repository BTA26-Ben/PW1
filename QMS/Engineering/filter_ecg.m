function filtered = filter_ecg(signal, Fs)
%FILTER_ECG Remove noise from ECG signal
%   TODO: Implement the following filters:
%       - Baseline wander removal (high-pass ~0.5Hz)
%       - 50Hz powerline interference (notch filter)
%       - High-frequency noise (low-pass ~40Hz)
%       - Motion artefacts
%       - EMG noise
%       - Electrode contact noise
%   Consider: Butterworth, wavelet, moving average, baseline offset

    filtered = signal;  % placeholder - returns unfiltered for now

end
