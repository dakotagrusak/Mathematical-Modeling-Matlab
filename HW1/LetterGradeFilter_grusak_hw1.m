% Dakota Grusak
% Math Modeling HW 1
% Problem #1
% Due 9/5/2018

% This scrip accept an ixput x betweex 1-100 and filters them according
% to a letter grading sceme

function grade=LetterGradeFilter(x)
    if (x >= 90 && x<=100)
        grade='A';
    elseif (x>=80 && x<=89)
        grade='B';
    elseif (x>=70 && x<=79)
        grade='C';
    elseif (x>=60 && x<=69)
        grade='D';
    elseif (x <= 59)
        grade='F';
    end
end
