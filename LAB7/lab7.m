clc
close all
clear all
a_a=0.2;
a_b=0.3;
b_a=0.00004;
b_b=0.00003;
T=300;

y_a=[0.2 0.5 0.8 1.0];
P_low=10e5;
P_high=50*1e5;
P=linspace(P_low,P_high,50);


figure
hold on
for i=1:length(y_a)
    
y_b=1-y_a(i);
a_mix=y_a(i)^2*a_a+2*y_a(i)*y_b*sqrt(a_a*a_b)+y_b^2*a_b;
b_mix=y_a(i)*b_a+y_b*b_b;
v_lower=b_mix+1e-10;
v_higher=100000;
%V=zeros(length(P),1);
phi=zeros(length(P),1);
for j=1:length(P)
v=fzero(@(v) vol(a_mix,b_mix,P(j),T,v),[v_lower,v_higher]);
%V(i)=v;
phi(j)=-log((P(j)*(v-b_mix))/(8.314*T))+b_a/(v-b_mix)-2*(y_a(i)*a_a+y_b*((a_a*a_b)^0.5))/(8.314*T*v);
end
plot(P,exp(phi));

end
hold off
grid on
legend('ya=0.2','ya=0.5','ya=0.8','ya=1.0')
title('fugacity vs pressure');
xlabel('pressure');
ylabel('fugacity');
function  volume=vol(a,b,P,T,v)
volume=(P+a/(v*v))*(v-b)-8.314*T;

end