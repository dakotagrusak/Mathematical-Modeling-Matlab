clc; clear all; close all;

%%%%%%%%%%%%%%%%%%%%%  | Can the two species of whales coexist? |  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% VARIABLES:
% x1 =  blue whales population (whales)
% x2 =  fin whales population (whales)
% growthB = blue whales population growth rate (whales/year)
% growthF = fin whale population growth rate (whales/year)

syms x1 x2
a = 1e-7;

growth1 = 0.05*x1*((x1-3000)/(x1+3000)) * (1-x1/150000) - a*x1*x2;
growth2 = 0.08*x2*((x2-15000)/(x2+15000)) * (1-x2/400000) - a*x1*x2;
growth = [growth1,growth2]

[x1sol,x2sol] = solve(growth,[x1,x2])

%%
figure(1)
hold on
[x1m,x2m] = meshgrid(0:10000:200000, 0:10000:500000);
growth1m = 0.05*x1m.*((x1m-3000)./(x1m+3000)) .* (1-x1m/150000) - a*x1m.*x2m;
growth2m = 0.08*x2m.*((x2m-15000)./(x2m+15000)) .* (1-x2m/400000) - a*x1m.*x2m;

% population vectors
magnitude = (growth1m.^2 + growth2m.^2).^0.5;
growth1_unit = growth1m./magnitude;
growth2_unit = growth2m./magnitude;
quiver(x1m,x2m,growth1_unit,growth2_unit)

    % solutions to the system
    pt_sol  = plot(x1sol, x2sol,'o')
    pt_sol.MarkerSize = 16;
    pt_sol.MarkerEdgeColor = 'red';
    pt_sol.MarkerFaceColor = 'yellow';

    % axes
    ax = gca;
    ax.FontSize = 14;
    xlabel('Blue Whale Population (whales)');
    ylabel('Fin Whale Population (whales)');

    % title
    tlt = title('Interaction of Blue and Fin Whale Species in Steady-State');
    tlt.FontSize = 16;
    tlt.FontWeight = 'bold';

    text(x1sol(1),x2sol(1),'both unstable','FontSize',14)
    % text(x1sol(2),x2sol(2),'unstable','FontSize',14)
    text(x1sol(3),x2sol(3),'unstable','FontSize',14)
    text(x1sol(4),x2sol(4),'stable','FontSize',14)
    text(x1sol(5),x2sol(5),'stable','FontSize',14)
    text(x1sol(6),x2sol(6),'unstable','FontSize',14)
    text(x1sol(7),x2sol(7),'semi-stable','FontSize',14)
    text(x1sol(8),x2sol(8),'semi-stable','FontSize',14)
hold off

%%%%%%%%%% (a)
% The two species cannot coexist. No solutions to the growth model occur where both whale species
% can maintain their minimum viable population levels.

%%%%%%%%%% (b)
% SEE PLOT


%%
figure(2)
hold on
[xa,ya] = fe_system(1,0,[5000 70000],1000,growth);
plot(xa,ya(:,1),'blue',xa,ya(:,2),'red')


growth2a = 0.08*x2*((x2-10000)/(x2+10000)) * (1-x2/400000) - a*x1*x2;
growtha = [growth1,growth2a]
[xd,yd] = fe_system(1,0,[5000 70000],1000,growtha);
plot(xd,yd(:,1),':',xd,yd(:,2),'--')
    % axes
    ax = gca;
    ax.FontSize = 14;
    xlabel('Time (years)');
    ylabel('Whale Population (whales)');
    % title
    tlt = title('Blue Whale and Fin Whale Population Timeline');
    tlt.FontSize = 16;
    tlt.FontWeight = 'bold';
    % legend
    lgd = legend;
    lgd.String = {'Blue Whale Population (x1 = 5,000)','Fin Whale Population (x2 = 70,000)'};
    lgd.FontSize = 12;

    hold off

%%%%%%%%%% (c)
% This model predicts that the fin whale population will continue to increase until they reach their
% population max capacity. From their initial population of 5000, the blue whale population will
% contiue to ddecrease until they have a population of 10,000.

%%%%%%%%%% (d)
% The model still predicts that the fin whale population will continue to increase until they reach
% their max popultion capacity. From their initial population of 5000, the blue whale population will
% contiue to ddecrease until they have a population of 0. The change in mimumim carrying capacity
% did not change the yielding population of each species.

%%
%%%%%%%%%% (e)
% Used ODE45 function to simulate the population with respect to time.

% part c. with ode45
[t,X_c] = ode45(@Growth_c, [0 1000], [5000;70e3])
[t,X_d] = ode45(@Growth_d, [0 1000], [5000;70e3])


figure(3)
    hold on
    pt_c = plot(t,X_c,':');
    pt_d = plot(t,X_d);
    % axes
    ax = gca;
    ax.FontSize = 14;
    xlabel('Time (years)');
    ylabel('Whale Population (whales)');
    % title
    tlt = title('Blue Whale and Fin Whale Population Timeline from ODE45');
    tlt.FontSize = 16;
    tlt.FontWeight = 'bold';
    % legend
    lgd = legend;
    lgd.String = {'Blue Whale Population','Fin Whale Population'};
    lgd.FontSize = 12;
    hold off


%%%%%%%%%% (f)
% implement the forward and modified eulers method to solve the system numerically
[t,X_fe] = fe_system(1,0,[5000 70000],1000,growth)
[t,X_me] = me_system(1,0,[5000 70000],1000,growtha)

figure(4)
    hold on
    pt_fe = plot(t,X_fe,'LineWidth',3)
    pt_fe(1).LineStyle = ':'
    pt_fe(2).LineStyle = '--'
    pt_me = plot(t,X_me,'LineWidth',3)
    % axes
    ax = gca;
    ax.FontSize = 14;
    xlabel('Time (years)');
    ylabel('Whale Population (whales)');
    % title
    tlt = title('Blue Whale and Fin Whale Population Timeline from FE and ME');
    tlt.FontSize = 14;
    tlt.FontWeight = 'bold';
    % legend
    lgd = legend;
    lgd.String = {'Blue Whale Population','Fin Whale Population'};
    lgd.FontSize = 12;
    hold off

%%%%%%%%%% (g)
% Analysis of the Sensitivity of each whale population to the effects of competition... or dx1/da
% and dx2/da
syms aa
growth1aa = 0.05*x1*((x1-3000)/(x1+3000)) * (1-x1/150000) - aa*x1*x2;
growth2aa = 0.08*x2*((x2-15000)/(x2+15000)) * (1-x2/400000) - aa*x1*x2;
growthaa = [growth1aa,growth2aa];

dgrowth1aa = diff(growth1aa,aa)
dgrowth2aa = diff(growth2aa,aa)


S_x1_a = double(subs(dgrowth1aa, [x1,x2], [x1sol(4),x2sol(4)]) * a/subs(growth1,[x1,x2],[x1sol(4),x2sol(4)]))

S_x2_a = double(subs(dgrowth2aa, [x1,x2], [x1sol(5),x2sol(5)]) * a/subs(growth2,[x1,x2],[x1sol(5),x2sol(5)]))


%% ODE45
function dP = Growth_c(t,X)
    a = 1e-7;
    dP(1) = 0.05*X(1).*((X(1)-3000)./(X(1)+3000)) .* (1-X(1)/150000) - a*X(1).*X(1);
    dP(2) = 0.08*X(2).*((X(2)-15000)/(X(2)+15000)) .* (1-X(2)/400000) - a*X(1).*X(2);
    dP = [dP(1);dP(2)];
end

function dP = Growth_d(t,X)
    a = 1e-7;
    dP(1) = 0.05*X(1).*((X(1)-3000)./(X(1)+3000)) .* (1-X(1)/150000) - a*X(1).*X(1);
    dP(2) = 0.08*X(2).*((X(2)-10000)/(X(2)+10000)) .* (1-X(2)/400000) - a*X(1).*X(2);
    dP = [dP(1);dP(2)];
end

%% Eulers Method
% Forward Eulers
function [xa,ya] = fe_system(h,x0,y0,xN,f)
    syms x1 x2
    N = ceil((xN-x0)/h)+1;
    ya = zeros(N,2);
    ya(1,:)=y0;
    xa = x0:h:xN;
    for i=2:N
        ya(i,:)=ya(i-1,:) + h*subs(f, [x1,x2], [ya(i-1,1),ya(i-1,2)]);
    end
end
% Modified Eulers
function [xa,ya] = me_system(h,x0,y0,xN,f)
    syms x1 x2
    N = ceil((xN-x0)/h)+1;
    ya = zeros(N,2);
    ya(1,:)=y0;
    xa = x0:h:xN;
    for i=2:N
        ya(i,:)=ya(i-1,:) + h*subs(f, [x1,x2], [ya(i-1,1), ya(i-1,2)]); %PREDICTOR --> y*
        ya(i,:) = ya(i-1,:) + (h/2)*(subs(f, [x1,x2], [ya(i-1,1), ya(i-1,2)]) + ...
        subs(f,[x1,x2],[ya(i-1,1),ya(i-1,2)])); % CORRECTOR
    end
end
