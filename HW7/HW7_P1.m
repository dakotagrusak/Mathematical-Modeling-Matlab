clc; close all; clear all; 

syms t 
k = log(10/28.6) - log(8/28.6);

tspan = linspace(-10,10);
T0 = 98.6; 
Ts = 72;

[t,T] = ode45(@(t,T) -k*(T-Ts), tspan, T0)

% row for values 
at_12am = find(T>81.75 & T<82.05)
at_1pm = find(T>79.7 & T<80.0913)


t12am = t(at_12am)
T12am = T(at_12am)
t1pm = t(at_1pm)
T1pm = T(at_1pm)

figure(1)
    hold on
    % curve plot
    p1 = plot(t,T);
    p1.LineStyle = ':';
    p1.Color = 'blue';
    p1.LineWidth = 1.5;
   
    % marker at 12pm
    pt_12pm = plot(t12am,T12am,'o');
    pt_12pm.MarkerSize = 16;
    pt_12pm.MarkerEdgeColor = 'red';
    pt_12pm.MarkerFaceColor = 'yellow';
    
    % marker at 1pm
    pt_1pm = plot(t1pm,T1pm,'o');
    pt_1pm.MarkerSize = 16;
    pt_1pm.MarkerEdgeColor = 'blue';
    pt_1pm.MarkerFaceColor = 'cyan';
   
    % axes
    ax = gca; 
    ax.FontSize = 14;
    xlabel('Time (hrs)');
    ylabel('Temperature (ºF)');
    
    % title
    tlt = title('Newtons Law of Cooling, Sys \rightarrow Dead Body');
    tlt.FontSize = 16; 
    tlt.FontWeight = 'bold';
    
    % legend
    lgd = legend;
    lgd.String = {'Body Temperature Profile','T at 12pm','T at 1pm'};
    lgd.FontSize = 12;        
%     lgd.NumColumns = 2;
    
    hold off   

t_death = 12 + t12am;   %6.4444
t_death = datestr(t_death,'HH:MM:SS')

% % %  The value obtained from the numerical approach differed slightly from that
% % %  from the numerical approach (t_death = 06:34AM). I think this has to do with my choice of
% % %  tspan. I results are still comparable because the t12am = -5.55 in the numerical approach
% % %  and the analytical approach got t12am = 5.4179. 

%%%%%% OVERLEAF link: 
% % % https://www.overleaf.com/8844387333nqgpfcshvkfc
