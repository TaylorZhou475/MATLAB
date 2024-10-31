function [] = norm_data_study(data)
figure

%Creating a histogram of the data
h = histogram(data);

%Calculating the average of the data
average = mean(data);

%Calculating the standard deviation of the data
stddeviation = std(data, 1);

disp(['The mean is ', num2str(average)]);
disp(['The standard deviation is ', num2str(stddeviation)]);

%Calculating how many elements are within 1, 2, 3 std of the mean
probability_vector = zeros(1, 3);
    for x = 1:3
        probability_vector(x) = sum(abs(data - average) <= x * stddeviation) / numel(data);
    end
    probability_vector 

    total_probability = [normcdf(1) - normcdf(-1), normcdf(2) - normcdf(-2), normcdf(3) - normcdf(-3)]

    % Calculate absolute error
    abs_error = abs( total_probability - probability_vector)
end

