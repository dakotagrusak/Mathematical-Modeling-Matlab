close all;
clear all;
clc;


%x: Number of wooden chairs
%y: Number of aluminum chairs
%
%%%%%Q1 & Q2
global d_P_x  d_P_y x y

syms x y;

P = @(x,y) (10 + 31*x^-0.5 + 1.3*y^-0.2)*x + ...
    (5 + 15*y^-0.4 + 0.8*x^-0.08)*y - 18*x - 10*y
d_P_x = diff(P,x)
d_P_y = diff(P,y)

%eqns = [d_P_x == 0, d_P_y==0];
%[a,b] = solve(eqns, x, y) %does not work (no analytical solution)

v0 = [1, 1];
sol = fsolve(@fun,v0)
a = double(sol(1)) %4.689585303926523
b = double(sol(2)) %5.851993667135362
P_max=double(subs(P,[x,y],[a,b])) %solving for the max profit by plugging in the critical points into the original function. 
%The maximum profit is $52.0727

d2_P_x = diff(d_P_x, x)
d2_P_y = diff(d_P_y, y)
d2_P_xy = diff(d_P_x, y)


D = double(subs(d2_P_x,[x,y],[a,b])) * double(subs(d2_P_y,[x,y],[a,b])) - ...
    double(subs(d2_P_xy,[x,y],[a,b]))^2
%D =  0.202351956964750


double(subs(d2_P_x,[x,y],[a,b]))
%d2_P_x = -0.746879123941511

figure
axes('Fontsize',14)
view(3)
hold all
fsurf(P,[0.1 10]);
plot3(a,b,P_max,'.r','LineWidth',4,'Markersize',20);
xlabel('Number of wooden chairs');ylabel('Number of aluminum chairs');zlabel('Profit ($)');
%plotting the surface of the profit and the maximum profit point

figure
axes('Fontsize',14)
hold all
fcontour(P, [0.1 10]);
plot3(a,b,P_max,'.r','LineWidth',4,'Markersize',20);
xlabel('Number of wooden chairs');ylabel('Number of aluminum chairs');zlabel('Profit ($)');
%plotting the contour plot of the profit and the maximum profit point

function F=fun(v)
    global d_P_x  d_P_y x y
    F(1)=double(subs(d_P_x,[x,y],[v(1),v(2)]));
    F(2)=double(subs(d_P_y,[x,y],[v(1),v(2)]));
end
