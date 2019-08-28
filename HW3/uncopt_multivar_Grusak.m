%% Dakota Grusak 
%       A manufacturer of lawn furniture makes two types of chairs one with
%       a wood frame and one with a tubular aluminum frame. The wood-frame
%       model costs $18 per unit to manufacture, and the aluminum-frame
%       model costs 10 per unit/ The company operate in a market where the
%       number of unuts that can be sold depends on the price. 
% 9-19-2018
% HW 3

%% Q1 & Q2: model and analytical approach to solve the model
clc; clear vars; close all; 

%------------------------------------------------------------------------
disp('-----------------------------------------------------------------')
disp('Q1: Profit model function and derivatives')
disp('-----------------------------------------------------------------')
%------------------------------------------------------------------------

% Initial declarations
global d_Pr_x d_Pr_y x y
syms x y % x=wood-frame units, y=alum-frame units
% Profit model

Pr = @(x,y) (x*(10 + 31*power(x,-0.5) + 1.3*power(y, -0.2)) + ...
    y*(5 + 15*power(y,-0.4) + 0.8*power(x,-0.08))) - ...
    (18*x + 10*y)

% 1st derivatives of Profit
d_Pr_x = diff(Pr, x)
d_Pr_y = diff(Pr, y)

%------------------------------------------------------------------------
disp('-----------------------------------------------------------------')
disp('Q2: Optimization results - optimized production for wood & alum, ')
disp('maximum profit and model surface and contour graphics')
disp('-----------------------------------------------------------------')
%------------------------------------------------------------------------

% Critical points of 1st derivative
criticalPoint = fsolve(@fun, [10,10]);
optUnitsWood = criticalPoint(1) % optimal production alum units
%   optUnitsWood = 4.6896
optUnitsAlum = criticalPoint(2) % optimal production wood units 
%   optUnitsAlum = 5.8520
maxProfit = Pr(criticalPoint(1), criticalPoint(2)) % maximum furniture profit
%   optMaxPr = 52.0727


% 2nd derivatives of Profit
d2_Pr_xx = diff(d_Pr_x, x)
d2_Pr_yy = diff(d_Pr_y, y)
d2_Pr_xy = diff(d_Pr_x, y)

secDerivTest = d2_Pr_xx.*d2_Pr_yy-(d2_Pr_xy).^2;
secDerivTest = double(subs(secDerivTest, [x,y], [1,1]))
if (D >= 0)
    disp('There are critical maxima')
else
    disp('The determinant is negative')
end 


warning('off', 'all');
% Profit Model Graphics 
figure(1)
axes('Fontsize', 14)
fsurf(Pr, [1, 20, 1, 20]);
colorbar
xlabel('Wood-frame model (units)')
ylabel('Aluminum-frame model (units)')
title('Furniture profit based on wood and aluminum models')


figure(2)
fcontour(Pr, [1, 20, 1, 20], 'Fill', 'on');
colorbar
xlabel('Wood-frame model (units)')
ylabel('Aluminum-frame model (units)')
title('Furniture profit based on wood and aluminum models')

%% Q3: Use fminunc to find minimum and use to plot critical points
%-----------------------------------------------
disp('-----------------------------------------------------------------')
disp('Q3: Optimizatation results using fminunc')
disp('-----------------------------------------------------------------')
%-----------------------------------------------

Pr_v = @(v) -Pr(v(1), v(2));

% look for the local maximum
v0 = [1, 1]; % [x0, y0] paired as a vector
[vopt, optMaxPr] = fminunc(Pr_v, v0);

optUnitsWood = vopt(1) % optimal number of wood units
%   optUnitsWood = 4.6896
optUnitsAlum = vopt(2) % optimal number of alum units
%   optUnitsAlum = 5.8520
optMaxPr = -optMaxPr
%   optMaxPr = 52.0727



%% Q4: Sensitivity Analysis
%-----------------------------------------------
disp('-----------------------------------------------------------------')
disp('Q4: Sensitivity Analysis')
disp('-----------------------------------------------------------------')
%-----------------------------------------------

% Sen_profitWood = 
    % S(Pr, costWood) = ? at (Pr0 = 
    % S(Pr, costWood) = dPr/dx * costWood/Prmax
syms msrpWood
msrpWood_0 = 18; 
profitMaxWood = optMaxPr;
profitSensiWood = @(x,y, msrpWood) ...
    (x*(10 + 31*power(x,-0.5) + 1.3*power(y, -0.2)) + ...
    y*(5 + 15*power(y,-0.4) + 0.8*power(x,-0.08))) - ...
    (msrpWood*x + 10*y);

% take the derivative with respect msrpWood
d_profitSensiWood_msrpWood = diff(profitSensiWood, msrpWood);
    diff_val_msrpWood = double(subs(d_profitSensiWood_msrpWood, optUnitsWood));
% sensitivity of profit to msrpWood 
Sensi_Pr_msrpWood = diff_val_msrpWood * msrpWood_0/profitMaxWood
%   Sensi_Pr_msrpWood = -1.6211
%   If the msrp of the wood-model unit of furniture increases by 1%, then 
%   the maximum optimized profit will decrease by $1.62. There will be a
%   loss of $1.62.


% Sen_profitAlum = 
    % S(Pr, costAlum) = ? at (Pr0 = 
    % S(Pr, costAlum) = dPr/dy * costAlum/Prmax
syms msrpAlum
msrpAlum_0 = 10; 
profitMaxAlum = optMaxPr;
profitSensiAlum = @(x,y, msrpAlum) ...
    (x*(10 + 31*power(x,-0.5) + 1.3*power(y, -0.2)) + ...
    y*(5 + 15*power(y,-0.4) + 0.8*power(x,-0.08))) - ...
    (18*x + msrpAlum*y);

% take the derivative with respect msrpAlum
d_profitSensiAlum_msrpAlum = diff(profitSensiAlum, msrpAlum);
    diff_val_msrpAlum = double(subs(d_profitSensiAlum_msrpAlum, optUnitsAlum));
% sensitivity of profit to msrpAlum 
Sensi_Pr_msrpAlum = diff_val_msrpAlum * msrpAlum_0/profitMaxAlum
%   Sensi_Pr_msrpAlum = -1.1238
%   If the msrp of the alum-model unit of furniture increases by 1%, then 
%   the maximum optimized profit will decrease by $1.12. There will be a
%   loss of $1.12.



%% Function declaration
% Using fsolve to find critical points
function F = fun(v)
    global d_Pr_x d_Pr_y
    global x y 
    F(1) = double(subs(d_Pr_x, [x, y], [v(1), v(2)]));
    F(2) = double(subs(d_Pr_y, [x, y], [v(1), v(2)]));
end



