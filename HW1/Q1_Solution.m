%%%Nihil Patel
close all;clear all;clc;

prompt = 'Please enter an integer number between 0 and 100: ';
x = input(prompt);
if isnumeric(x)==1 && x>=0 && x<=100
    if x<=59
        disp('The corresponding grade is an F')
    end
    
    if x>=60 && x<=69
        disp('The corresponding grade is a D')
    end
    
    if x>=70 && x<=79
        disp('The corresponding grade is a C')
    end
    
    if x>=80 && x<=89
        disp('The corresponding grade is a B')
    end
    
    if x>=90 && x<=100
        disp('The corresponding grade is an A')
    end
else
    disp('Your number is out of the range 0 - 100.')
end
