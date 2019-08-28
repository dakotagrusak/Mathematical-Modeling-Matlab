%%%Full Name

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Q1 & Q2: model and analytical approach to solve the model
clc; clear all; close all

syms d;
%defining the variable d, d==days

profit=(200+5*d)*(65-d)-45*d; %defining the profit function
d_P=diff(profit); %getting the derivative of the profit function

optimal_day=solve(d_P==0) %solving for the critical point (the optimal day to sell the pig to get max profit)
%the optimal day to sell the pig was found to be 8
optimal_profit_in_cents=subs(profit,d,optimal_day) %solving for the maximum profit by substituting the critical point back into the original profit function
%the maximum profit obtained would be 13320 cents

%to test if the critical value is the maximum or minimum, use the 2nd
%derivative test
d2_P = diff(d_P)
%Since the 2nd derivative is negative at the critical value, it is the
%local max (also abs max in this case since the profit function is
%quadratic

figure
axes('Fontsize',14)
hold all
fplot(profit,[0,15]);
plot(optimal_day,optimal_profit_in_cents,'or');
xlabel('# of days')
ylabel('Profit (cents)')
%plotting the profit function as well as the maximum profit point

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Q3: use fminunc
fun=@(d)-1*((200+5*d)*(65-d)-45*d);
%defining the profit function for the selling of the pig where d =  number of days. The whole
%function is mulitplied by -1 because fminunc finds a minimum, and we are
%looking for a maximum in this funtion.

x0=0; %initial guess for fminunc
[x,fval]=fminunc(fun,x0); %this outputs the critical point (x=the day the pig should be sold) and the function value associated with that critical point (fval=the max profit)
day_to_sell=x
fval=-fval %this is correcting for multiplying the resulting "fval" by -1 to return the maximum value
%the best day to sell the pig is at 8 days, and the
%maximum profit obtained would be 1332 0 cents

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Q4: sensitivity analysis
%

syms gr;
%defining the variable for the sensitivity analysis
%gr=growth rate, which was made a variable to test the sensitivity of the
%profit to it

gr_profit=(200+gr*d)*(65-d)-45*d; %defining the profit function with the growth rate as a variable
dPdGR=diff(gr_profit,gr)

gr0=5; %original growth rate value
d0=optimal_day;
P0=optimal_profit_in_cents;
%these are the values from solving Q2

S_gr_profit=double(subs(dPdGR,d,d0)*gr0/P0) %solving for the sensitivity number of the pig growth rate
%the sensitivity number (with max profit at 13320 cents and day sold at 8)
%for the pig growth rate is 0.1712, meaning that for every 1% increase in
%pig growth rate from 5 lb/day, there is a 0.1712% increase in max profit from $13,320. 


