function [] = DFTDenoising(threshold)
    % This function performs denoising on a noisy signal in the DFT domain 
    % using a specified threshold to filter out low-magnitude components.
    close all;

    % Set the random seed for reproducibility
    rng("default");

    % Define frequencies for the clean signal
    f1 = 1;
    f2 = 10;
    f3 = 20;

    % Generate a time vector from 0 to 255 (normalized by 256)
    t = [0:255] / 256;

    % Create a clean signal composed of multiple sinusoidal components
    clean_signal = 3 * sin(2 * pi * f1 * t) + cos(2 * pi * f2 * t) + 2 * sin(2 * pi * f3 * t);

    % Add Gaussian noise to the clean signal
    gaussian_noise = randn(1, 256);
    noisy_signal = gaussian_noise + clean_signal;

    % Plot the clean signal
    figure;
    fig1 = tiledlayout(3, 1);
    nexttile;
    plot(clean_signal);
    title('Clean Signal');
    xlabel('Time');
    ylabel('x(t)');

    % Plot the noisy signal
    nexttile;
    plot(noisy_signal);
    title('Noisy Signal');
    xlabel('Time');
    ylabel('x(t)');

    % Compute the Discrete Fourier Transform (DFT) of the noisy signal
    DFT = fft(noisy_signal, 256);
    magnitude = abs(DFT);  % Calculate the magnitude of the DFT

    % Plot the magnitude of the DFT of the noisy signal
    figure;
    fig2 = tiledlayout(2, 1);
    nexttile;
    plot(t, magnitude);
    title('Magnitude of DFT of Noisy Signal');
    xlabel('Sample');
    ylabel('Amplitude');

    % Apply thresholding to remove low-magnitude components
    index = abs(magnitude) < threshold;  % Find components below threshold
    magnitude(index) = 0;  % Set magnitudes below threshold to zero

    % Plot the magnitude of the DFT after thresholding (denoised signal)
    nexttile;
    plot(t, magnitude);
    title('Magnitude of DFT of Denoised Signal');
    xlabel('Sample');
    ylabel('Amplitude');

    % Set the corresponding DFT coefficients to zero
    DFT(index) = 0;

    % Compute the inverse DFT to reconstruct the denoised signal
    inverse_DFT = ifft(DFT);

    % Calculate and display the Mean Squared Error (MSE) between the clean and reconstructed signals
    MSE = mean((clean_signal - inverse_DFT).^2);
    disp(['Mean Squared Error: ', num2str(MSE)]);

    % Plot the reconstructed signal
    nexttile(fig1);
    plot(inverse_DFT);
    title('Reconstructed Signal');
    xlabel('Time');
    ylabel('x(t)');
end
