function [trellis, tx_cc] = task_2(tx_sc)
% TASK 2: Channel Coding using Convolutional Code
% Input:
%   tx_sc - Source-coded binary stream (row vector)
% Output:
%   trellis - Trellis structure of the convolutional encoder
%   tx_cc - Convolutionally encoded bitstream

% Define parameters for convolutional encoder
constraintLength = 7;                         % Constraint length
codeGenerator = [171 133];                    % Palitan-able value

% Create trellis structure
% poly2trellis expects generator polynomials in octal
trellis = poly2trellis(constraintLength, codeGenerator);

% Encode the source-coded binary stream using convolutional encoding
% Convert input to row vector (just to be sure)
tx_sc = tx_sc(:)';
tx_cc = convenc(tx_sc, trellis);

% Notes for report:
% Generator polynomials used: G1 = 171 (octal), G2 = 133 (octal)
% Constraint Length: 7
% Coding Rate: 1/2
% The trellis has 2 output bits for every input bit

end
