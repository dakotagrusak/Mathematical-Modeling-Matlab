%Math Modeling HW1-Problem 2 Solution
%Written by: Daniel Henkes

%Because we don't know how many years it will take, a while loop should
%be used.
clear all;

Amount = 500;
Yearly_Input = 500;
Interest = 1.1;
k=0;
while Amount < 10000
    k=k+1;
    Amount = Amount*Interest + Yearly_Input;
end
fprintf('The final amount will be $%f after %d years.\n',Amount,k)
