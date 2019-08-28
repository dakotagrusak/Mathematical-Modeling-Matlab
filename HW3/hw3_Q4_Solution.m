close all;
clear all;
clc;
%x: Number of wooden chairs
%y: Number of aluminum chairs
%

%%%%%From Q2, we know that with the cost of $18/unit for wood-frame model
%and $10/unit for aluminum model, the maximum profit P_max is $52.0727
%when the number of wood chairs = 4.6896 and the number of aluminum chairs = 5.8520
P_max = 52.0727;
x_max = 4.6896;
y_max = 5.8520;

%%%%%Q4
syms x y w a;

%Find S(P,w) = dP_w*18/P_max where w is the cost of the wood-frame model
P = @(x,y) (10 + 31*x^-0.5 + 1.3*y^-0.2)*x + ...
    (5 + 15*y^-0.4 + 0.8*x^-0.08)*y - w*x - 10*y
d_P_w = diff(P,w)

S_P_w = double(subs(d_P_w,[w,x,y],[18,x_max,y_max])*18/P_max)
%the sensitivity number for the wooden chair cost is -1.6211. This means
%that (for the maximum profit at $52.0727, the number of wooden chairs sold
%at 4.6896) for every 1% increase in the wooden chair cost from $18, there is a
%1.6211% decrease in max profit from $52.0727.


%Find S(P,a) = dP_a*10/P_max where a is the cost of the aluminum-frame model
P = @(x,y) (10 + 31*x^-0.5 + 1.3*y^-0.2)*x + ...
    (5 + 15*y^-0.4 + 0.8*x^-0.08)*y - 18*x - a*y
d_P_a = diff(P,a)

S_P_a = double(subs(d_P_a,[a,x,y],[10,x_max,y_max])*10/P_max)
%the sensitivity number for the aluminum chair cost is -1.1238. This means
%that (for the maximum profit at $52.0727, the number of aluminum chairs sold
%at 5.8520) for every 1% increase in the wooden chair cost from $10, there is a
%1.1238% decrease in max profit from $52.0727.