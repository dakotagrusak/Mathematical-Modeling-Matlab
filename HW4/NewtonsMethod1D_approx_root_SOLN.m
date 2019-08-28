clc; clear all; close all;
format long

prompt = 'Please enter an integer number greater than 2\n (for the number of decimal places of accuracy): ';
Nd = input(prompt);

syms x 
F = @(x) x^7 - 1000; 

figure
axes('Fontsize',14)
hold all
fplot(F)
plot([-5, 5], [0, 0], '--')


d_F_x = diff(F, x);

x(1) = 3.0; %be careful with the initial guess. If you choose the value to be
%smaller than 3, the tangent line there is almost flat (subs(d_F_x, x(1))
%close to 0). Then Newton's method will fail!

x(2) = x(1) - subs(F, x(1))/subs(d_F_x, x(1));
i = 2;

%the following condition can be changed depending on how the 
%the number of decimal places of accuracy is defined
while abs(x(i) - x(i-1))>=10^(-Nd)
    i = i+1
    x(i) = x(i-1) - subs(F, x(i-1))/subs(d_F_x, x(i-1));
end
double(x')

plot(x(end), F(x(end)), 'or')
