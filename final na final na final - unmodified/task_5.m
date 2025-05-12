function [rx_m] = task_5(rx, M, pad_zeros)
% Task 3: Demodulation Stage
%Inputs:
% - rx = received modulated signal
% - M = modulation order
% - pad_zeros = number of zeros padded
%Output:
% - rx_m = output of the demodulator ; demodulated signal

% Removing of padded zeros
    Y = rx(1:end-pad_zeros);

% QAM Demodulation
    rx_m = qamdemod(Y, M, 'OutputType','bit','UnitAveragePower',true);
end