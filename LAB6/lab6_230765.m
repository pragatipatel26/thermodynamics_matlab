clc
clear all
close all
%%question1
A = readmatrix("P_Z_phi.csv");

P = A(:,1);%in atm
Z = A(:,2);
phi_exp = A(:,3);%(in atm)

%%X = exp((Z-1)./P);
phi_sim = zeros(27,1);

for i=2:length(P)
   P_temp = P(1:i);
   X_temp = (Z(1:i)-1)./P(1:i);
   
   phi_sim(i)= exp(trapz(P_temp,X_temp));
end
figure
plot(P,phi_sim,'-o');
hold on
plot(P,phi_exp,'-o');
legend('phisim','phiexp');
hold off
grid on
xlabel('pressure')
ylabel('fugacity coefficient')
%%question2
B = readmatrix("P_V.csv");

P = B(:,1);%in atm
V = B(:,2);%in litre/mol
P=P*101325;
V=V*0.001;


g=zeros(102,1);
for i=2:length(P)
   P_temp = P(1:i);
   V_temp = V(1:i);
   
   g(i) = trapz(P_temp,V_temp);
end
figure
plot(P,g,'-o')
grid on
xlabel('pressure');
ylabel('g');
hold on
%%question3
T=100+273.15;%in kelvin
R=8.314;
T_c=405.6;
P_c=111.5*101325;
a=(27*R*R*T_c*T_c)/(64*P_c);
b=(R*T_c)/(8*P_c);
g_new=vdw_fugacity(a,b,P,T);

plot(P,g_new,'-*')
hold off
legend('g','gnew');