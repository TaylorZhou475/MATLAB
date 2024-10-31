function [] = Quantization(delta)
    % Read the image
    img = imread('barbara.pgm');
    figure;
    imshow(img);  % Display the original image
    
    % Convert the image to double precision for computation
    double_img = double(img);
    
    % Define an 8x8 DCT transform matrix
    T = dct(eye(8));
    
    % Get the dimensions of the image
    [rows, columns] = size(img);
    
    % Initialize a matrix to store the reconstructed image
    reconstructed_image = zeros(rows, columns);
    
    % Initialize a counter for non-zero DCT coefficients after quantization
    counter = 0;
    
    % Loop through each 8x8 block in the image
    for i = 1:8:rows
        for j = 1:8:columns
            % Extract the current 8x8 block
            current_square = double_img(i:i+7, j:j+7);
            
            % Apply the DCT to the current block
            orig_DCT_coefficients = T * current_square * T';
            
            % Quantize the DCT coefficients by dividing by delta, rounding,
            % and multiplying back by delta
            quantization = round(orig_DCT_coefficients ./ delta) * delta;
            
            % Count the non-zero elements in the quantized DCT block
            non_zero = quantization ~= 0;
            counter = counter + sum(non_zero, 'all');
            
            % Apply the inverse DCT to reconstruct the block
            reconstructed_block = T' * quantization * T;
            
            % Place the reconstructed block back into the output image
            reconstructed_image(i:i+7, j:j+7) = reconstructed_block;
            
            % Display matrices of the first block for debugging
            if i == 1 && j == 1
                current_square  % Original 8x8 block
                orig_DCT_coefficients  % DCT coefficients
                quantization  % Quantized DCT coefficients
                reconstructed_block  % Reconstructed 8x8 block
            end
        end
    end

    % Print the count of non-zero DCT coefficients after quantization
    fprintf('The number of non-zeros is %f\n', counter);

    % Clip values in the reconstructed image to fit within [0, 255]
    index = reconstructed_image > 255;
    index2 = reconstructed_image < 0;
    reconstructed_image(index) = 255;
    reconstructed_image(index2) = 0;

    % Compute the Mean Squared Error (MSE) between original and reconstructed image
    MSE = sum(sum((double_img - reconstructed_image).^2)) / rows / columns;
    fprintf('The mean squared error is %f\n', MSE);
    
    % Convert the reconstructed image back to uint8 for display
    reconstructed_image = uint8(reconstructed_image);
    figure;
    imshow(reconstructed_image);  % Display the reconstructed image
end
