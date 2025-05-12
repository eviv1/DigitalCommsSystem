%% Digital Communication System Simulation

% Load an image (ensure it is high quality for best results)
img = imread('windows xp.jpg');  % Replace with your desired image filename

%% TASK 1: Source Encoding using Fixed-Length Coding
[m, n, p, q, tx_sc, R_channel, G_channel, B_channel] = task_1(img);

%% TASK 2: Channel Coding using Convolutional Code
[trellis, tx_cc] = task_2(tx_sc);

%% TASK 3: Modulation (M-QAM)
M = 4;                  % Modulation order (e.g., 4-QAM)
k = log2(M);            % Bits per symbol
[tx_m, pad_zeros] = task_3(tx_cc, k, M);  % Modulate using M-QAM

%% TASK 4: Transmission through Noisy Channel
SNR_vec = 0:4:20;      % SNR values to test (can adjust as needed), shud b saem
BER_vec = zeros(1,length(SNR_vec));     % for BER
PerError = [];    % for percent error

% Loop through each SNR level (optional: save results per SNR)

for i = 1:length(SNR_vec)
    [rx, cd] = task_4(SNR_vec, tx_m, i); %% TASK 5: Demodulation (M-QAM)
    rx_m = task_5(rx, M, pad_zeros);       % Demodulate received signal

    %% TASK 6: Channel Decoding using Viterbi Decoder
    rx_cc = task_6(rx_m, trellis);         % Decode using Viterbi algorithm

    %% TASK 7: Source Decoding and Image Reconstruction
    fprintf('\n--- Results for SNR = %d dB ---\n', SNR_vec(i));
    [I_check, cc_check, percent_error] = task_7(rx_cc, tx_sc, p, q, m, n, img);
    BER_vec(i) = cc_check;
    PerError(i) = percent_error;
end
   
%% Probability of Errors
figure;

plot(SNR_vec,PerError, '-o');  
title('Probability Error over Different SNRs\n (with channel coding)');
xlabel('Signal-to-Noise Ratio (dB)');
ylabel('Percentage Error (%)');
grid on;
