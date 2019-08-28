close all;
clear all;
clc;


%x: Number of wooden chairs
%y: Number of aluminum chairs
%
%%%%%Q3
syms x y;

P = @(x,y) -((10 + 31*x.^-0.5 + 1.3*y.^-0.2).*x + ...
    (5 + 15*y.^-0.4 + 0.8*x.^-0.08).*y - 18*x - 10*y)
Pv=@(v) P(v(1),v(2));
x0=[1,1]; %initial guess for fminunc
[sol,P_max]=fminunc(Pv,x0); %using fminunc to find the critical points and the maximum profit

wooden_chairs_to_be_sold= sol(1) %the first value in sol is the critical point for the wooden chairs variable
aluminum_chairs_to_be_sold= sol(2) %the second value in sol is the critical point for the aluminum chairs variable
P_max=-P_max %this is correcting for multiplying the whole function by -1 for fminunc*
%the number of wooden chairs that needs to be sold per day to maximize
%profit is 4.6896, and the number of aluminum chairs that needs to be sold per day to maximize
%profit is 5.8520. The maximum profit was found to be $52.0727

