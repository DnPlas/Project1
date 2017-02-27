% ------ SYSTEM 4 ------
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
yss = 13.53;
y_max = 19.5;
mp = (y_max-yss)/yss;
tp = 0.0765;
k = yss;

% ----- CALCULATING VARIABLES -----
wd = pi/tp; 
syms d;
eqn= mp == exp((-d*pi)/sqrt(1-(d*d)));
d_d = vpasolve(eqn,d);
dd = double(d_d);
wn = (wd/(sqrt(1-(dd*dd))));

G = tf((k*(wn*wn)) , [1 (2*dd*wn) (wn*wn)]);
[y,t] = step(G);

% ------ A ------
G_A = G*b
[y_a,t_a] = step(G_A);
Parameters = {'Damping Factor'; 'Natural Frequency'; 'Natural Damping Frequency'};
Results_Open_Loop = [dd;wn;wd];
T = table(Results_Open_Loop, 'RowNames', Parameters)

% ------ B -------
k_b = a;
r_b = b;
G_B = tf((k*(wn*wn)*k_b*r_b) , [1 (2*dd*wn) ((wn*wn)+(k_b*k*wn*wn))]);
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
yss_d = (k*(wn*wn)*k_b*r_b)/((wn*wn)+(k_d*k*wn*wn));
e_d = 0.05;
eqn= r_d - yss_d == e_d;
disp('Controller K is:')
k_dd = vpasolve(eqn, k_d)   

% ------ E ------
r_e = a + c;
k_e = double(k_dd);
G_E = tf((k*(wn*wn)*k_e*r_b) , [1 (2*dd*wn) ((wn*wn)+(k_e*k*wn*wn))]);
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