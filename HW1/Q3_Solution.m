% Full name

close all;
clear all;
clc;

format long 

m = 0:1:20; %month 0 to 20
p = zeros(size(m)); %rabbit population from month 0 to 20

%% Fibonacci sequence
p(1) = 1;
p(2) = 1;
for i = 3:length(m)
    p(i) = p(i-1) + p(i-2);
end

%% Base e
fun = @(r)exp(r*m)-p; %approximate function (r: growth rate)
r0 = 0.5; %initial guess
[r_result, resnorm, residual, exitflag] = lsqnonlin(fun,r0); 
    %resulting rate (from nonlinear least-squares solver)
r_result
exitflag

%%%%%%%%%%%%%%%compute population at a future month "n" (n > 20) to see
%%%%%%%%% how well the fitting curve can predict the population in the future
n = 21; %month 21 
p_test = fibonacci(n+1); 
%population at month 21 (notice that fibonacci(1) is population at month 0)
%%%%%%%%%%%%%%%%%%%%

percentErrExp = abs(exp(r_result*n)-p_test)/p_test*100

figure
axes('FontSize',14)
hold all
plot(m,p,'-or',m,exp(r_result*m),'--b','linewidth',2)
legend('population',['approximation: e^{',num2str(r_result),'*m}'])
xlabel('time (month)')
ylabel('number of rabbits')

%%%%%%%%%%%%

%% Base 2
fun = @(r)2.^(r*m)-p; %approximate function (r: growth rate)
r0 = 0.5; %initial guess
[r_result, resnorm, residual, exitflag] = lsqnonlin(fun,r0); 
    %resulting rate (from nonlinear least-squares solver)
r_result
exitflag

percentErr2 = abs(2.^(r_result*n)-p_test)/p_test*100

figure
axes('FontSize',14)
hold all
plot(m,p,'-or',m,2.^(r_result*m),'--b','linewidth',2)
legend('population',['approximation: 2^{',num2str(r_result),'*m}'])
xlabel('time (month)')
ylabel('number of rabbits')

%%%%Conclusion:
%percentErrExp = 2.613682569606641%
%percentErr2 = 2.613682584415193%
%which are pretty similar, i.e., both fitting curves (bases) return the
%predicted population of 2.6% from the true value.
%Notice that we only want to fit a curve to the data from month 0 to 20 
%when using "lsqnonlin". Then compare the approximate results from the 
%fitting curves with the population in the "future" n > 20.
%If we try n = 30, 40, 50, etc., it will show you that the fit is good 
%(i.e., the percent error is small) when the future month n is close to 20. 
%As n increases, the percent error increases which means that the fit is no longer suitable.
