% Dakota Grusak

close all;
clear all;
clc;
format long 

m = 0:1:20; %month
p = zeros(size(m)); %rabbit population

%% Fibonacci sequence
p(1) = 1;
p(2) = 1;
for i = 3:length(m)
    p(i) = p(i-1) + p(i-2);
end

%%%%%%%%%%%%%%%compute population at a future month "n" for testing
n = 20; % at n=20 no significant difference is seen, but as n increases
m_test = 0:1:n; 
p_test = zeros(size(m_test)); 
p_test(1) = 1;
p_test(2) = 1;
for i = 3:length(m_test)
    p_test(i) = p_test(i-1) + p_test(i-2);
end
%%%%%%%%%%%%%%%


%% Base e
fun = @(r)exp(r*m)-p; %approximate function (r: growth rate)
r0 = 0.5; %initial guess
[r_result, resnorm, residual, exitflag] = lsqnonlin(fun,r0); 
    %resulting rate (from nonlinear least-squares solver)
r_result
exitflag

percentErrExp = (exp(r_result*m_test(end))-p_test(end))/p_test(end)*100

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

percentErr2 = 100*(2.^(r_result*m_test(end))-p_test(end))/p_test(end)
% maxPercentErrBase2 = max(percentErrBase2) % compare this value to base 2

figure
axes('FontSize',14)
hold all
plot(m,p,'-or',m,2.^(r_result*m),'--b','linewidth',2)
legend('population',['approximation: 2^{',num2str(r_result),'*m}'])
xlabel('time (month)')
ylabel('number of rabbits')

%% Justification
% The percent error for both models are similar at n~20 with insignificant 
% differences valued at less than 1%. The model deviates from the Fibonacci
% sequence as n increases. 

% The base e model was more accurate than the base 2 model. 







