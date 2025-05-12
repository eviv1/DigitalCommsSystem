function [rx, cd] = task_4(SNR_vec, tx_m, i)
% task_4 - Simulates passing the modulated signal through a noisy channel
% and displays the received signal's constellation diagram.
%
% INPUTS:
% - SNR_vec: Vector containing the SNR levels to be used in dB.
% - tx_m: Modulated signal.
% - i: Index indicating the SNR level from the SNR_vec.
%
% OUTPUTS:
% - rx: Signal after adding noise.
% - cd: Constellation diagram object.

% Add AWGN noise to the modulated signal based on current SNR level
rx = awgn(tx_m, SNR_vec(i), 'measured');

% Create a constellation diagram object
cd = comm.ConstellationDiagram;

scatterplot(rx)
end
