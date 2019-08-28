%% HW7_P2
% use ODE45 to solve mass-spring system (motion)
clc; close all; clear all; 

global m k
m = 0.5; 
k = 2;

%% (1)
[t1,X1] = ode45(@spring_undamped, [0,9], [-1,1])

%% (2)
[t2,X2] = ode45(@spring_exforce, [0,9], [-1,1])

%% Graphics 
figure(1)
    hold on
    yline = hline(0)
        yline.LineStyle = '-';
    p1 = plot(t1,[X1(:,1),X1(:,2)]);
        p1(1).LineStyle = '-';
        p1(1).Color = 'red';
        p1(2).LineStyle = '-';        
        p1(2).Color = 'blue';
    p2 = plot(t2,[X2(:,1),X2(:,2)]);
        p2(1).LineStyle = ':';
        p2(1).Color = 'red';
        p2(2).LineStyle = ':';
        p2(2).Color = 'blue';

    ax = gca;
    ax.FontSize = 12;
    xlabel('Time (s)');
    ylabel('Position/Velocity (m or m/s)'); 
        
    tlt = title({'Position & Velocity for Mass-Spring'; 'm = 0.5 [kg], k=0.2 [N/m]'});
    tlt.FontSize = 16;
    tlt.FontWeight = 'bold';
        
    lgd = legend;
    lgd.String = {'position (undamped)','velocity (undamped)',...
                        'position (ex-force)','velocity (ex-force)'};
    lgd.FontSize = 12;        
    lgd.NumColumns = 2;

    hold off        

% % % % % I know this could have been written much shorter but I wanted to mess around with the
% % % % % different ways of manipulating the txt.
    

%% FUNCTION declaration
%[position | velocity]
function df = spring_undamped(~,X)
    global k m
    df = [X(2); (-k/m)*X(1)];
end

%[position | velocity]
function df = spring_exforce(~,X)
    global k m
    c = 0.2;
    df = [X(2); (-1/m)*(c*X(1)+k*X(1))];
end 
