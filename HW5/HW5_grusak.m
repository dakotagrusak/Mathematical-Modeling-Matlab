% Dakota Grusak
%   Use numerical methods instead of the analytic methods to solve the
%   above problem. The problem in the TV optimization problem worked in
%   class.

close all; clear vars; clc;

% x1: Number of 19in displays
% x2: Number of 21in displays
% a: price elasticity
syms x1 x2 a
format shortG

a = [0.01, 0.0101];
P = (339 - a(1) * x1 - 0.003 * x2) * x1 ...
    + (399 - 0.01 * x2 - 0.004 * x1) * x2 ...
    - (195 * x1 + 225 * x2 + 400000);
dP = gradient(P);

figure (1)
x1domain = [-1e4, 1e4];
x2domain = [-1e4, 1e4];
fsurf(P, [x1domain, x2domain])
xlabel('19-inch LCD panel')
ylabel('21-inch LCD panel')
hold all
disp('------------------------------------------------------')

%% (a)
% Determine the production levels x 1 and x 2 that maximize the objective
% function y = f(x1,x2). Use the two?variable version of 
% NewtonRaphson?s method.

%%%Random search (initial guess)
[xrand, yrand, zrand] = rand_search(-10,10,-10,10,20,P);

%%%Newton's Method
N = 20;
v = zeros(N, 2); 
v(1,:) = [xrand,yrand]; 
J = jacobian(dP, [x1, x2]); 
J_inv = inv(J);
plot(v(1,1), v(1,2), 'kx')

for i = 2:N
    v(i,:) = v(i-1,:)' - subs(J_inv, [x1 x2], v(i-1,:))* ...
        subs(dP, [x1 x2], v(i-1,:));
end
disp('Numerical Optimization:')
disp('Optimized production for 19in and 21in with origional a (price elasticity):')
disp(v(N,:))
plot(v(N,1), v(N,2), 'bo')
P_max = double(subs(P, [x1,x2], v(N,:)));


%% (b)
%   Let a denote the price elasticity for 19in sets. In part (a),
%   we assumed ?a? = 0.01. Now assume that ?a? increases by 1%, what will
%   be the new values for each TV set and the profit function?.

%   Use your results to obtain a numerical estimate of the sensitivities:
%   S(x1,a), S(x2,a), and S(y, a). .

Pnew = (339 - a(2) * x1 - 0.003 * x2) * x1 ...
    + (399 - 0.01 * x2 - 0.004 * x1) * x2 ...
    - (195 * x1 + 225 * x2 + 400000);
dPnew = gradient(Pnew);

%%% Newton's method with an increased price elasticity
v_new = zeros(N,2);
v_new(1,:) = [xrand, yrand];
Jnew = jacobian(dPnew, [x1, x2]);
Jnew_inv = inv(Jnew);

for i = 2:N
    v_new(i,:) = v_new(i-1,:)' - subs(Jnew_inv, [x1, x2], v_new(i-1,:))*...
        subs(dPnew, [x1, x2], v_new(i-1,:));
end
disp('Optimized production for 19in and 21in with increased a (price elasticity):')
disp(v_new(N,:))
Pnew_max = double(subs(Pnew, [x1,x2], v_new(N,:)));

%%% Sensitivity
% S(x1,a) = (change in x1/change in a) * (original a/original x1)
Sensitivity_x1a = (v_new(N,1)-v(N,1))/(a(2)-a(1)) * (a(1)/v(N,1))
Sensitivity_x2a = (v_new(N,2)-v(N,2))/(a(2)-a(1)) * (a(1)/v(N,2))
Sensitivity_f_a = (Pnew_max - P_max)/(a(2)-a(1)) * (a(1)/P_max)
    % Sensitivity_x1a = -1.1268
    % Sensitivity_x2a = 0.26514
    % Sensitivity_f_a = 0.072769

% Compare these to the sensitivity results obtained analytically with
% derivatives
%       The sensitivity values with repect to x1 and x2 for both analytical and
%       numerical solutions are equal. This is because each method calculated
%       an equal optimied production volume. The sensitivity values for profit to
%       variation in price elasticity are equal for the same aforementioned
%       reason.
%

disp('------------------------------------------------------')

%% (c)
% Compare the analytic methods (Second Derivative Test) to the numerical
% methods employed in this problem. Which do you prefer? Explain your
% reason.

% Numerical:    P_max = 5.5364e+05

% ANALYTICAL SOLUTION to compare
d2P_x1x1 = diff(dP(1), x1);
d2P_x2x2 = diff(dP(2), x2);
d2P_x1x2 = diff(dP(1), x2);
secondDerTest = det([d2P_x1x1 d2P_x1x2;  d2P_x2x2 d2P_x1x2;]);

disp('Analytical Optimization:')
disp('Optimized production for 19in and 21in with origional a (price elasticity):')
[x1_theory,x2_theory] = solve([dP(1)==0, dP(2)==0], x1,x2);
v_theory = [double(x1_theory) double(x2_theory)];
disp(v_theory)
P_maxtheory = double(subs(P, [x1, x2], [x1_theory,x2_theory]));
    % P_maxtheory = 5.5364e+05

d2Pnew_x1x1 = diff(dPnew(1), x1);
d2Pnew_x2x2 = diff(dPnew(2), x2);
d2Pnew_x1x2 = diff(dPnew(1), x2);
secondDerTestNew = det([d2Pnew_x1x1 d2Pnew_x1x2;  d2Pnew_x2x2 d2Pnew_x1x2;]);

disp('Optimized production for 19in and 21in with increased a (price elasticity):')
[x1_theoryNew,x2_theoryNew] = solve([dPnew(1)==0, dPnew(2)==0], x1,x2);
v_theoryNew = [double(x1_theoryNew) double(x2_theoryNew)];
disp(v_theoryNew)
Pnew_maxtheory = double(subs(Pnew, [x1 x2], [x1_theoryNew,x2_theoryNew])) ;
    % Pnew_maxtheory = 5.5142e+05

Sensitivity_x1a_theory = double((x1_theoryNew - x1_theory)/(a(2)-a(1)) * (a(1)/x1_theory))
Sensitivity_x2a_theory = double((x2_theoryNew - x2_theory)/(a(2)-a(1)) * (a(1)/x2_theory))
Sensitivity_f_a_theory = (Pnew_maxtheory - P_maxtheory)/(a(2)-a(1)) * (a(1)/P_maxtheory)
    % Sensitivity_x1a_theory =  -1.1268
    % Sensitivity_x2a_theory = 0.26514
    % Sensitivity_f_a_theory = -0.4004

%       The analytical method is prefered to the numerical method.
%       The numerical solution is an approximation while the analytical
%       method provides an exact solution for the model. Although both
%       solutions reterned the same numerical values other the exact
%       solutions for the analytical solutions should always be used when
%       possible. More complex models (e.g. PDEs - heat diffusion equations,
%       reynold transport theorem), exist where assumptions must be used to
%       to simplify the problem in order for the analytical solution to yield
%       a numerical result.
