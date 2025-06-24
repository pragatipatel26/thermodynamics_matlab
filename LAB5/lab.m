clc
clear all
close all
%%question1 part1
filename='PV_data.csv';
data=readtable(filename);
P=data.Pressure_atm;
V=data.Volume_L;
%%question1 part2
T=300;
R=0.0821;

fun = @(x,V)(R*T./(V-x(2))-x(1)./(V.^2));

x0=[1,0.05];
x=lsqcurvefit(fun,x0,V,P);
times = linspace(V(1),V(end));
figure
plot(V,P,'ko',times,fun(x,times),'b-')
legend('Data','Fitted Function')
title('Data and Fitted Curve')
disp(x);
%%question1 part3
T=[200 300 350 400];
P=(R*T./(V-x(2))-x(1)./(V.^2));
figure
hold on
for i=1:length(T)
    P=(R*T(i)./(V-x(2))-x(1)./(V.^2));
    plot(V,P);

end
hold off
legend('200','300','350','400');
xlabel('volume');
ylabel('pressure');
title('pressure vs volume');

%%question2
figure
hold on
a=x(1);
b=x(2);
density=linspace(0,10,30);

T=[200 300 350 400];
for i=1:length(T)
departure=(-a/(R*T(i))).*density+1./(1-density.*b)-a/(R*T(i))-1;
plot(density,departure)
end
hold off
title('departure function vs density');
xlabel('density');
ylabel('departure function')

