% Dakota Grusak
% Math Modeling
% HW4: Newton's Method (1D)

%       Implement the Newton method to find a solution of x^7 - 1000 = 0 
%       correct to ?n? decimal places where ?n? is an integer > 2 and is 
%       an input from the command line.

%% -----------------------------------------------------------------------
clc; clear all; close all; 

syms x
f = @(x) x^7 - 1000; % defined function
df = diff(f, x); % 1st derivative
x0 = 3; % initial guess

%% User input for Newtons method tolerance
fprintf('\n'); 
disp('Define the tolerance (n) of the calculated root')
prompt = 'n = '; 
n = input(prompt); 

%% Figure
figure (1)
hold all
fplot(f)
plot([-5, 5], [0, 0], '--')
axis([-5 5 -0.5e4 0.5e4])
xlabel('x-axis')
ylabel('y-axis')

%% Algorithm 
% Newtons Method Algorithm - 1D
format long
rootTolerance = power(10, -n);
currentRoot = x0;
count = 0;
while (abs(subs(f, currentRoot)) > rootTolerance)
    currentRoot = double(currentRoot - subs(f, currentRoot)/subs(df, currentRoot));
    count = count + 1;
end 

%% Approximate zero of function
% The calculated roots
fprintf('Iterations required:')
disp(count)
fprintf('The root value is:')
disp(currentRoot)

plot(currentRoot, subs(f, currentRoot), 'o')







