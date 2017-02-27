% ------ SYSTEM 1 ------
%   Daniela Plascencia
%
% This script lets the user know a set of characteristics
% from a first order control system

% ------ CLEAR WORKSPACE ------
clear;
clc;

% ------ CONSTANTS ------
a = 3;
b = 5;
c = 1.7;
G = tf(b, [a,c])
[y,t] = step(G);
% ------ A ------
G_A = G*b
[y_a,t_a] = step(G_A);
S_A = stepinfo(G_A);
disp('System 1-A');
disp(S_A);

% ------ B -------
k_b = a;
G_B = tf((b*k_b*b), [a,(c+(b*k_b))])
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
yss_d = (b*k_d)/(c+(b*k_d));
e_d = 0.05;
eqn= r_d - yss_d == e_d;
disp('Controller K is:')
k_dd = vpasolve(eqn, k_d)

% ------ E ------
r_e = a + c;
k_e = double(k_dd);
num = b*r_e*k_e;
den = c+(k_e*b);
G_E = tf(num, [a, den])
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
