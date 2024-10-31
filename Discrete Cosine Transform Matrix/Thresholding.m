function [] = Thresholding(T)
    % This function performs thresholding on an audio sample in both the time domain
    % and the DCT domain, using a threshold value T.

    % Load the 'handel' audio sample data
    load handel.mat;
    
    % Use the first 25600 samples from the audio
    y = y(1:25600);
    
    % Plot the original audio sample
    figure;
    plot(y);
    title('Original Sample');
    
    % Play the original audio sample
    sound(y, Fs);
    pause(5);  % Pause to allow the audio to finish playing

    % Time Domain Processing
    y2 = y;  % Create a copy of the audio sample
    index = abs(y2) < T;  % Find indices where the absolute value of y2 is less than T
    y2(index) = 0;  % Set values below threshold T to zero

    % Calculate and display the Mean Absolute Error (MAE) for the time domain processing
    MAE = mean(abs(y2 - y));
    fprintf('The Mean Absolute Error is %f\n', MAE);

    % Plot the thresholded audio in the time domain
    figure;
    plot(y2);
    title('Time Domain Processing With Threshold T');

    % Play the thresholded audio in the time domain
    sound(y2, Fs);
    pause(5);

    % DCT Domain Processing
    y3 = y;  % Create another copy of the original audio sample
    y4 = zeros(25600, 1);  % Initialize a vector to store the DCT-processed audio

    % Create a 64x64 DCT transformation matrix
    C = dct(eye(64));

    % Process the audio in 64-sample blocks using the DCT
    for i = 1:64:25600
        x = y3(i:i+63);  % Extract a 64-sample block from the audio
        z = C * x;  % Compute the DCT of the block
        index2 = abs(z) < T;  % Find DCT coefficients below threshold T
        z(index2) = 0;  % Set small DCT coefficients to zero
        xhat = C' * z;  % Compute the inverse DCT to reconstruct the block
        y4(i:i+63) = xhat(:);  % Store the reconstructed block in y4
    end

    % Update y3 with the DCT-processed audio
    y3 = y4;

    % Calculate and display the Mean Absolute Error (MAE) for the DCT domain processing
    MAE2 = mean(abs(y3 - y));
    fprintf('The Mean Absolute Error is %f\n', MAE2);

    % Plot the thresholded audio in the DCT domain
    figure;
    plot(y3);
    title('DCT Domain Processing With Threshold T');

    % Play the thresholded audio in the DCT domain
    sound(y3, Fs);
    pause(5);
end
