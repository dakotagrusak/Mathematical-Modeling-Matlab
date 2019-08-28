% Dakota Grusak
% Math Modeling HW 1
% Problem #2
% Due 9/5/2018

% Find how long it will take to accumulate at least $10,000 in a bank account
% if you deposit $500 initially and $500 at the end of each year, if the
% account pays 10% annual interest.

%Known:
Value = 500; %investment value
P = 500; %principal investment
A = 500; %annual investment
i = 0.1; %interest rate 
t = 0; %time ????


%Math:  
while Value < 10000
    t=t+1;
    Value = Value*1.1 + 500;
end 
Value
t
    
    
