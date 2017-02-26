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
G = tf([(c*(-0.002)) 2*c], [1 (a+(2*b)) (2*b*a)])
[y,t] = step(G);

% ------ A ------
G_A = G*b;
[y_a,t_a] = step(G_A);
S_A = stepinfo(G_A);
wn = sqrt(30);
d = 13/(2*wn);
wd = 1;
Parameters = {'Damping Factor'; 'Natural Frequency'; 'Natural Damping Frequency'};
Results_Open_Loop = [d;wn;wd];
T = table(Results_Open_Loop, 'RowNames', Parameters)
disp('System 1-A');
disp(S_A);


% ------ B -------
k_b = a;
G_B = tf([(k_b*c*(-0.004/8)) (k_b*c*1)/4], [1 ((b+(k_b*c*(-0.004/2))))/4 (((a*a)+k_b*c*1))/4]);
[y_b,t_b] = step(G_B);
S_B = stepinfo(G_B);
disp('System 1-B');
disp(S_B);

% ------ C ------
set(figure, 'name', 'S1: Root Locus Diagrams', 'numbertitle', 'off');
subplot(2,2,[1,2]);
rlocusplot(G);
title('System 1');
subplot(2,2,3);
rlocusplot(G_A);
title('System 1-A');
subplot(2,2,4);
rlocusplot(G_B);
title('System 1-B');

% ------ D ------
r_d = 1;
syms k_d;
yss_d = ((k_d*c*1)/4)/((((a*a)+k_d*c*1))/4);
e_d = 0.05;
eqn= r_d - yss_d == e_d;
disp('Controller K is:')
k_dd = vpasolve(eqn, k_d)   

% ------ E ------
r_e = a + c;
k_e = double(k_dd);
G_E = tf([(r_e*k_e*c*(-0.004/8)) (r_e*k_e*c*1)/4], [1 ((b+(k_e*c*(-0.004/2))))/4 (((a*a)+k_e*c*1))/4]);
[y_e,t_e] = step(G_E);
S_E = stepinfo(G_E);
disp('System 1-E');
disp(S_E);

% ------ RESPONSES PLOT ------
set(figure, 'name', 'S1: Responses', 'numbertitle', 'off');
subplot(2,2,1);
plot(t,y);
title('System 1');
subplot(2,2,2);
plot(t_a,y_a);
title('System 1-A');
subplot(2,2,3);
plot(t_b,y_b);
title('System 1-B');
subplot(2,2,4);
plot(t_e,y_e);
title('System 1-E');