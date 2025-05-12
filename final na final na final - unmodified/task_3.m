function [tx_m, pad_zeros] = task_3(tx_cc, k, M)
% Task 3: Modulation Stage
% Inputs:
% - tx_cc = transmitted channel code sequence to be modulated
% - k = bits per symbol
% - M = modulation order
% Outputs:
% - tx_m = output of the modulator ; modulated signal
% - pad_zeros = number of zeros paddded

    pad_zeros = mod(-mod(numel(tx_cc), k), k);
    padded_tx_cc = [tx_cc, zeros(1, pad_zeros)];

% QAM Modulation
    tx_m = qammod(padded_tx_cc', M, 'InputType','bit','UnitAveragePower',true);

% Constellation Diagram
    scatterplot(tx_m)
    title('Constellation Diagram')
    
end
