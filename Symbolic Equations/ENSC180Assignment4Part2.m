close all
clear all

% Define symbolic variables x and y
syms x y

% Define the first equation
eqn1 = (x + 2)^2 + y^2 == 30;

% Define the second equation
eqn2 = x + 4*y + 2*(y^2) == 5;

% Define a system of equations
eqns = [(x + 2)^2 + y^2 == 30, x + 4*y + 2*(y^2) == 5];

% Define a system of expressions (without the equality)
eqns1 = [(x + 2)^2 + y^2, x + 4*y + 2*(y^2)];

% Solve the system of equations for x and y
solution = solve(eqns);

% Display the number of solutions for x
fprintf('The number of solutions is %f\n', numel(solution.x));

% Convert the symbolic solutions for x and y to numeric values
double_x = double(solution.x);
double_y = double(solution.y);

% Display symbolic solutions for x
fprintf('The symbolic solution for x are:\n');
disp(solution.x);

% Display symbolic solutions for y
fprintf('The symbolic solution for y are:\n');
disp(solution.y);

% Display numeric solutions for x
fprintf('The numerical solution for x are:\n');
disp(double_x);

% Display numeric solutions for y
fprintf('The numerical solution for y are:\n');
disp(double_y);

% Substitute the first solution (x, y) pair into the expressions for verification
sub_eqn1 = subs(eqns1, [x, y], [double_x(1), double_y(1)]);
verified_answer1 = double(sub_eqn1);

% Substitute the second solution (x, y) pair into the expressions for verification
sub_eqn2 = subs(eqns1, [x, y], [double_x(2), double_y(2)]);
verified_answer2 = double(sub_eqn2);

% Substitute the third solution (x, y) pair into the expressions for verification
sub_eqn3 = subs(eqns1, [x, y], [double_x(3), double_y(3)]);
verified_answer3 = double(sub_eqn3);

% Substitute the fourth solution (x, y) pair into the expressions for verification
sub_eqn4 = subs(eqns1, [x, y], [double_x(4), double_y(4)]);
verified_answer4 = double(sub_eqn4);

% Plot the first equation as a red dashed line
figure;
line1 = fimplicit(eqn1, [-8, 8, -8, 8]);
set(line1, 'LineStyle', '--', 'Color', 'r', 'LineWidth', 2);
hold on;

% Plot the second equation as a blue dash-dot line
line2 = fimplicit(eqn2, [-8, 8, -8, 8]);
set(line2, 'LineStyle', '-.', 'Color', 'b', 'LineWidth', 2);

% Plot the solution points on the graph
s = stem(double_x, double_y, 'fill');
set(s, 'LineWidth', 2);
