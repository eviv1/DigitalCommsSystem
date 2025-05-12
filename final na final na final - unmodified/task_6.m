function [rx_cc] = task_6(rx_m, trellis)
% task_6 - a function that performs channel decoding using
% convolutional codes for a (2,1,2) code.
% This uses the Viterbi Decoding Algorithm.
% 
% INPUTS:
% rx_m - received codewords (modulated signal)
% trellis - trellis structure used in encoding
% 
% OUTPUTS:
% rx_cc - decoded message

% Hard decision decoding: Map received symbols to binary (0 or 1)
rx_m_hard = rx_m > 0; 

% Traceback length (this is the depth of the decoding process)
tb = 2; % Palitan mo na lang kahit anong number bahala ka buhay mo

% Viterbi decoding using the trellis structure and hard decision decoding
rx_cc = vitdec(rx_m_hard(:), trellis, tb, 'cont', 'hard'); 

end
