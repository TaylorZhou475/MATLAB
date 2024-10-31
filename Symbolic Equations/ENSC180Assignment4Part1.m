clear all
close all
% Define x values (independent variable) and y values (dependent variable)
x = 2 : 6;
y = [65 67 75 71 68];

% Initialize cell arrays to store symbolic equations and coefficients for each polynomial degree
symbolic_equations = cell(1, 4);
coefficients = cell(1, 4);

% Initialize an array to store Mean Squared Error (MSE) values for each polynomial fit
MSE_values = zeros(1, 4);

% Loop over polynomial degrees from 1 to 4
for i = 1:4
    % Display the current polynomial degree in the command window
    fprintf('Degree %f\n', i)
    
    % Compute polynomial coefficients for the current degree
    coefficient = polyfit(x, y, i);
    
    % Store the coefficients in the cell array
    coefficients{i} = coefficient;
    
    % Convert polynomial coefficients to symbolic form and store in cell array
    sym_coefficients = poly2sym(coefficients{i});
    symbolic_equations{i} = sym_coefficients;
end

% Create a 2x2 tiled layout for subplots
t = tiledlayout(2, 2);

% Degree 1 polynomial plot
nexttile;
plot(x, y, 'o');  % Plot original data points
hold on;
x1 = linspace(2, 6, 100);  % Generate fine x values for smooth curve
y1 = polyval(sym2poly(symbolic_equations{1}), x1);  % Evaluate polynomial at x1
plot(x1, y1);  % Plot the polynomial fit
Y1 = polyval(coefficients{1}, x);  % Evaluate polynomial at original x points
MSE_values(1) = sum((y - Y1).^2) / length(y);  % Calculate MSE for Degree 1
title('Degree 1');

% Degree 2 polynomial plot
nexttile;
plot(x, y, 'o');  
hold on;
y2 = polyval(sym2poly(symbolic_equations{2}), x1);  
plot(x1, y2);
title('Degree 2');
Y2 = polyval(coefficients{2}, x);  
MSE_values(2) = sum((y - Y2).^2) / length(y);  % Calculate MSE for Degree 2

% Degree 3 polynomial plot
nexttile;
plot(x, y, 'o');  
hold on;
y3 = polyval(sym2poly(symbolic_equations{3}), x1);  
plot(x1, y3);
title('Degree 3');
Y3 = polyval(coefficients{3}, x);  
MSE_values(3) = sum((y - Y3).^2) / length(y);  % Calculate MSE for Degree 3

% Degree 4 polynomial plot
nexttile;
plot(x, y, 'o');  
hold on;
y4 = polyval(sym2poly(symbolic_equations{4}), x1);  
plot(x1, y4);
title('Degree 4');
Y4 = polyval(coefficients{4}, x);  
MSE_values(4) = sum((y - Y4).^2) / length(y);  % Calculate MSE for Degree 4

% Display the MSE for each polynomial degree
for j = 1:4
    fprintf('The Mean Squared Error of Degree %0.1f is %0.30f\n', j, MSE_values(j));
end
