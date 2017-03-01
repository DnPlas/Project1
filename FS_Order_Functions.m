Y = Y3;
max_y_val = max(max(Y(:,1),Y(:,2)));
yss = max(Y(:,2));
tss = 0.98*(max(Y(:,1)));

if (max_y_val > yss)
    disp('TF is second order')
    Mp = (max_y_val - yss)/yss;
    k = yss;

else
    disp('TF is first order')
    G = tf(yss , [tss 1])
    [y,t] = step(G);

plot(Y(:,1),Y(:,2));
hold
plot(t,y);