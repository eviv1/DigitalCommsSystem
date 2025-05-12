function [m, n, p, q, tx_sc, R_channel, G_channel, B_channel] = task_1(img)
    % TASK1_SCRIPT Performs source encoding using fixed-length (8-bit) coding for RGB images.
    %
    %   INPUT:
    %       img - RGB image matrix to be encoded 
    %
    %   OUTPUT:
    %       m, n       - Dimensions of the resized image
    %       p, q       - Bit lengths of the encoded Red and Green channels
    %       tx_sc      - Final encoded binary vector for all RGB channels
    %       R_channel  - Extracted Red channel 
    %       G_channel  - Extracted Green channel 
    %       B_channel  - Extracted Blue channel
    %       tx_matrix  - The encoded transmission matrix (24 bits per pixel)

    %% Step 1: Resize the input image to 256x256
    resized_img = imresize(img, [256 256]);  % Resize image 
    [m, n, ~] = size(resized_img);  % Get the dimensions (m x n)

    %% Step 2: Separate RGB Channels
    R_channel = double(resized_img(:, :, 1));  % Extract Red channel 
    G_channel = double(resized_img(:, :, 2));  % Extract Green channel
    B_channel = double(resized_img(:, :, 3));  % Extract Blue channel 

    %% Step 3: Encode each pixel as an 8-bit fixed-length binary string
    R_flat = R_channel(:);  % Flatten the Red channel into a vector
    G_flat = G_channel(:);  % Flatten the Green channel into a vector
    B_flat = B_channel(:);  % Flatten the Blue channel into a vector

    % Convert each pixel value into an 8-bit binary string and then to numeric values 
    R_bin = dec2bin(R_flat, 8)';  % Each column = one pixel's 8-bit code
    G_bin = dec2bin(G_flat, 8)';
    B_bin = dec2bin(B_flat, 8)';

    % Ensure that each channel is the same length 
    assert(length(R_bin) == length(G_bin) && length(G_bin) == length(B_bin), 'Channel lengths do not match');

    % Convert the binary matrices into a single vector of binary values
    encoded_R = reshape(R_bin, 1, []);  % Flatten matrix to a single row for Red channel
    encoded_G = reshape(G_bin, 1, []);  % Flatten matrix to a single row for Green channel
    encoded_B = reshape(B_bin, 1, []);  % Flatten matrix to a single row for Blue channel

    % Create the final transmission vector 
    tx_sc = double([encoded_R == '1', encoded_G == '1', encoded_B == '1']);  % Convert characters to logical values


    %% Step 6: Bit lengths for Red and Green channels
    p = double(length(encoded_R));  % Bit length for Red channel as double
    q = double(length(encoded_G));  % Bit length for Green channel as double
    total_bits = double(length(tx_sc));  % Total number of bits 

    % Display the total length of the encoded data in bits
    fprintf('\nFixed-Length Encoded Total Length: %.0f bits\n', total_bits);

    %% Step 7: Compute Entropy and Efficiency
    % Compute the entropy of each channel using the formula: H = -sum(p * log2(p))
    prob_R = histcounts(R_channel, 0:256) / numel(R_channel);
    prob_G = histcounts(G_channel, 0:256) / numel(G_channel);
    prob_B = histcounts(B_channel, 0:256) / numel(B_channel);
    
    entropy_R = -sum(prob_R(prob_R > 0) .* log2(prob_R(prob_R > 0)));  % Entropy for Red channel
    entropy_G = -sum(prob_G(prob_G > 0) .* log2(prob_G(prob_G > 0)));  % Entropy for Green channel
    entropy_B = -sum(prob_B(prob_B > 0) .* log2(prob_B(prob_B > 0)));  % Entropy for Blue channel

    avg_code_length = 8.0;  % For fixed-length encoding, the average code length is 8 bits

    % Compute the coding efficiency for each channel
    efficiency_R = entropy_R / avg_code_length;  % Efficiency for Red channel
    efficiency_G = entropy_G / avg_code_length;  % Efficiency for Green channel
    efficiency_B = entropy_B / avg_code_length;  % Efficiency for Blue channel

    %% Step 8: Display Results
    fprintf('\nEntropy and Efficiency (Fixed-Length 8-bit Coding):\n');
    fprintf('Red Channel:   Entropy = %.4f bits, Efficiency = %.4f\n', entropy_R, efficiency_R);
    fprintf('Green Channel: Entropy = %.4f bits, Efficiency = %.4f\n', entropy_G, efficiency_G);
    fprintf('Blue Channel:  Entropy = %.4f bits, Efficiency = %.4f\n', entropy_B, efficiency_B);

    %% Step 9: Save Color Code, Probability, and Codeword to CSV
    save_to_csv(R_channel, prob_R, 'Red');
    save_to_csv(G_channel, prob_G, 'Green');
    save_to_csv(B_channel, prob_B, 'Blue');

end

%% Helper Function to Save Data to CSV
function save_to_csv(channel_data, probabilities, color_name)
    % Convert the probabilities into a table with Color Code, Probability, and Codeword
    color_codes = (0:255)';
    Bcodewords = dec2bin(color_codes, 8);  % Generate the 8-bit binary codewords
    ProbabilityTable = table(color_codes, probabilities', Bcodewords, 'VariableNames', {'Color Code', 'Probability', 'Codeword'});

    % Write the table to a CSV file
    filename = sprintf('%s_channel_probability.csv', color_name);
    writetable(ProbabilityTable, filename);
    fprintf('%s channel probability and codeword data saved to: %s\n', color_name, filename);
end