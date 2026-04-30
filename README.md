# PW1 — The Puzzling Echocardiogram

EE22005 Engineering Practice & Design — University of Bath

## Overview

MATLAB-based ECG signal analysis tool built for the Year 2 Project Week 1 puzzle game. The program loads ECG signals from multiple formats, filters noise, detects waveform features, and outputs differential diagnoses.

## File Structure

```
PW1/
├── QMS/
│   ├── Quality documents/
│   │   ├── Quality manual/
│   │   ├── Procedure/
│   │   └── Forms/
│   ├── Quality control/
│   ├── Engineering/          ← MATLAB code goes here
│   ├── Operations/
│   ├── Purchasing/
│   ├── Sales customer service/
│   ├── Human resources/
│   └── Documents gallery/
└── README.md
```

## MATLAB Modules

| File | Purpose |
|------|---------|
| `main_ecg_analysis.m` | Main script — set filename and Fs, then run |
| `load_ecg.m` | Signal loader for .mat, .csv, .dat, and raw ADC |
| `filter_ecg.m` | Noise removal (baseline wander, 50Hz, high-freq) |
| `detect_features.m` | R-peak detection, heart rate, PQRST identification |
| `diagnose_ecg.m` | Differential diagnosis from detected features |

## Usage

1. Place all `.m` files in the same folder
2. Open `main_ecg_analysis.m` in MATLAB
3. Set `filename` to your signal file and `Fs` to the correct sampling frequency
4. Run the script

## Supported Diagnoses (WIP)

**Simple:** Bradycardia, Tachycardia, Atrial Fibrillation, Long QT Syndrome

**Complex (TODO):** STEMI, Bigeminy/Trigeminy, Sick Sinus Syndrome, Brugada, WPW, LGL

## Data Sources

- [PhysioNet](https://physionet.org/about/database/) — ECG-ID, QT, MIT-BIH Arrhythmia, AF Termination Challenge
- Signal Simulator (provided on Moodle)
- AD8232 ECG Kit (available after Thursday qualification)
