function [I_check, cc_check, percent_error] = task_7(rx_cc, tx_sc, p, q, m, n, img)
% TASK 7: Source Decoding
% This function reconstructs an RGB image from the received fixed-length source codeword.
%
% Inputs:
%   rx_cc       - Received channel codeword (string or char array) 
%   tx_sc       - Transmitted source codeword (original) 
%   p           - Length of encoded Red channel in bits
%   q           - Length of encoded Green channel in bits
%   m, n        - Original image dimensions (256 x 256)
%   img         - Original transmitted image (RGB)
%
% Outputs:
%   I_check         - Reconstructed RGB image (decoded)
%   cc_check        - Bit error count between transmitted and received sequences
%   percent_error   - Percentage of bit errors

% Convert the received codeword (rx_cc) and the transmitted codeword (tx_sc) to character arrays
  % Remove the first 2 elements and add 0 and 1 at the end (dinaya ko to)
    rx_cc = rx_cc.';
    rx_cc = [rx_cc(3:end), 0, 0];

    rx_cc = char(rx_cc + '0'); % Received channel codeword
    rx_cc = string(rx_cc); 
    tx_sc= join(string(tx_sc), '');

    %% Step 1: Ensure inputs are char arrays
    % Convert the received codeword (rx_cc) and the transmitted codeword (tx_sc) 
    rx_cc = char(rx_cc);  % Received channel codeword
    tx_sc = char(tx_sc);  % Transmitted source codeword

    %% Step 2: Separate the received binary string into RGB channels
    % The received codeword is split into separate binary strings for each color channel (Red, Green, Blue).
    red_rx   = rx_cc(1 : p);  % First p bits correspond to the Red channel
    green_rx = rx_cc(p + 1 : p + q);  % Next q bits correspond to the Green channel
    blue_rx  = rx_cc(p + q + 1 : end);  % Remaining bits correspond to the Blue channel

    %% Step 3: Convert binary strings to 8-bit segments
    % Convert the received binary strings for each channel into 8-bit segments to represent pixel values.
    red_matrix   = reshape(red_rx, 8, [])';  
    green_matrix = reshape(green_rx, 8, [])';  
    blue_matrix  = reshape(blue_rx, 8, [])';  

    %% Step 4: Convert binary to decimal pixel values (uint8)
    % Convert each 8-bit binary segment to a decimal pixel value.
    red_vals   = uint8(bin2dec(red_matrix));  % Convert Red channel binary to decimal
    green_vals = uint8(bin2dec(green_matrix));  % Convert Green channel binary to decimal
    blue_vals  = uint8(bin2dec(blue_matrix));  % Convert Blue channel binary to decimal

    %% Step 5: Reshape flat vectors back into 2D image channels
   
    R_rec = reshape(red_vals, m, n); 
    G_rec = reshape(green_vals, m, n);  
    B_rec = reshape(blue_vals, m, n);  

    %% Step 6: Reconstruct the RGB image
    % The individual RGB channels are combined to form the full reconstructed RGB image.
    I_check = cat(3, R_rec, G_rec, B_rec);  % Combine

    %% Step 7: Resize the decoded image to the original image size (if necessary)
    I_check_resized = imresize(I_check, [size(img, 1), size(img, 2)]);  % Resize to match original dimensions

    %% Step 8: Bit Error Calculation
    % Calculate the number of bit errors between the transmitted and received codewords.
    cc_check = sum(tx_sc ~= rx_cc);  % Count the number of bit differences between tx_sc and rx_cc
    total_bits = length(tx_sc);  % Total number of bits in the transmitted codeword
    percent_error = (cc_check / total_bits) * 100;  % Calculate the percentage of bit errors

    %% Step 9: Plot the Transmitted and Received Images Side by Side
   
    figure;
    sgtitle('SNR: %d');

    
    subplot(1, 2, 1);
    imshow(img);  
    axis off;  
    title('Transmitted Image');  

    
    subplot(1, 2, 2);
    imshow(I_check_resized);  
    axis off;  
    title('Received Image');  

    % Print error details, gaano ka ka putanginang mali
    fprintf('Bit Error Count: %d\n', cc_check);  
    fprintf('Percentage Error: %.2f%%\n', percent_error);  
end
