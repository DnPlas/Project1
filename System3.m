% ------ SYSTEM 3 ------
%   Daniela Plascencia
%
% This script lets the user know a set of characteristics
% from a second order control system

% ------ CLEAR WORKSPACE ------
clear;
clc;

% ------ CONSTANTS ------
a = 3;
b = 5;
c = 1.7;
G = tf([(c*(-0.005)) 2*c], [1 (a+(2*b)) (2*b*a)])
[y,t] = step(G);

% ------ A ------
G_A = G*b
[y_a,t_a] = step(G_A);
wn = sqrt((a*a)/4);
d = b/(2*wn);
wd = 1;
Parameters = {'Damping Factor'; 'Natural Frequency'; 'Natural Damping Frequency'};
Results_Open_Loop = [d;wn;wd];
T = table(Results_Open_Loop, 'RowNames', Parameters)

% ------ B -------
k_b = a;
r_b = b;
G_B = tf([(r_b*k_b*c*(-0.005)) ,(r_b*k_b*2*c)] , [1 ((k_b*c*(-0.005))+a+(2*b)) (2*b*a+(2*c*a))])
[y_b,t_b] = step(G_B);

% ------ C ------
set(figure, 'name', 'S3: Root Locus Diagrams', 'numbertitle', 'off');
subplot(2,2,[1,2]);
rlocusplot(G);
title('System 3');
subplot(2,2,3);
rlocusplot(G_A);
title('System 3-A');
subplot(2,2,4);
rlocusplot(G_B);
title('System 3-B');

% ------ D ------
r_d = 1;
syms k_d;
yss_d = (2*c*k_d)/((2*b*a)+(k_d*2*c));
e_d = 0.05;
eqn= r_d - yss_d == e_d;
disp('Controller K is:')
k_dd = vpasolve(eqn, k_d)   

% ------ E ------
r_e = a + c;
k_e = double(k_dd);
G_E = tf([(r_e*k_e*c*(-0.005)) ,(r_e*k_e*2*c)] , [1 ((k_e*c*(-0.005))+a+(2*b)) ((k_e*2*c)+(b*a))])
[y_e,t_e] = step(G_E);

% ------ RESPONSES PLOT ------
set(figure, 'name', 'S3: Responses', 'numbertitle', 'off');
subplot(2,2,1);
plot(t,y);
title('System 3');
subplot(2,2,2);
plot(t_a,y_a);
title('System 3-A');
subplot(2,2,3);
plot(t_b,y_b);
title('System 3-B');
subplot(2,2,4);
plot(t_e,y_e);
title('System 3-E');
