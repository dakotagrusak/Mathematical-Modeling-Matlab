%Dakota Grusak
% Math Modeling
% Homework Assignment 2
clc; clear all; close all; 

%% Pig Profit Model 
% Pr = weight*price - cost
Profit = @(t) (200+5*t) * (0.65 - 0.01*t) - (0.45*t);

% plot of pig profit with respect to time 
time=linspace(0,20);
modelProfit = subs(Profit, time);
figure
axes('FontSize',12)
hold all
plot(time,modelProfit, '--b', 'linewidth',2)
title('Pig Market Profit')
xlabel('Time (days)')
ylabel('Profit ($)')


%% Profit maximization method
Profit_max = @(t) (-1)*((200+5*t) * (0.65 - 0.01*t) - (0.45*t));
t0 = 5; 
[t_Pr_max, f_Pr_max] = fminunc(Profit_max, t0);
t_Pr_max
for Pr_max = -f_Pr_max, 
    format bank
    Pr_max
end
plot(t_Pr_max, Pr_max, '.r', 'markersize', 20)

% Summary: the maximum profit that a pig can fetch from market is $133.20 
% at t = 8 days 


%% Sensitivity analysis
% S(Profit, t) = ? at (Pr0 = 130, Pr_max) 
syms t
d_Profit_t = diff(Profit, t);
S_Profit_t = double(subs(d_Profit_t,t,130)*130/Pr_max)

% S_Profit_t = -11.91: If Profit increases 1% from $130, then the pig  
% profit will decrease by 11.91% from the Profit maximum (Pr_max =
% $133.20).








