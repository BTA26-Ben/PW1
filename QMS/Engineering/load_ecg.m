function [signal, time] = load_ecg(filename, Fs)
%LOAD_ECG Load ECG signal from file
%   Supports: .mat, .csv, .dat, raw ADC
%   TODO: Add proper handling for each format

    [~, ~, ext] = fileparts(filename);

    switch lower(ext)
        case '.mat'
            data = load(filename);
            % TODO: extract the right variable from the .mat file
            signal = [];  % placeholder

        case '.csv'
            data = readmatrix(filename);
            signal = data(:, 2);  % assumes signal is column 2

        case '.dat'
            % TODO: handle PhysioNet .dat format
            signal = [];

        otherwise
            % TODO: handle raw ADC
            signal = [];
    end

    signal = signal(:);
    time = (0:length(signal)-1)' / Fs;
end
