clear
clc
w=0.225;
P_c=7.38*1e6;
T_c=304.2;
R=8.314;
k=0.37464+1.54226*w-0.26992*(w^2);
a=(0.45724*(R^2)*(T_c^2))/P_c;
b=(0.07780*R*T_c)/P_c;

alpha = @(T) (1+k.*(1-(T./T_c)^1/2)).^2;

P = @(V,T) (R.*T)./(V-b)-(alpha(T).*a)./(V.*(V+b)+b.*(V-b));

V = linspace(0.1,0.3,100);
%isothermal curve
figure
plot(V,P(V,250))
hold on
plot(V,P(V,300))
plot(V,P(V,350))
plot(V,P(V,400))
plot(V,P(V,450))
hold off
xlabel('Volume')
ylabel('Pressure')

Cv = @(T) 20+0.01.*T+(1e-5).*(T).^2;
d_alpha_dT = @(T) -k./sqrt(T*T_c).*(1+k-k.*sqrt(T/T_c));
dP_dT= @(V,T) (R)./(V-b)-(d_alpha_dT(T).*a)./(V.*(V+b)+b.*(V-b));
%adiabatic ode (T-V curve)
dT_dV = @(V,T) ((-T).*(dP_dT(V,T)))./Cv(T);
V_span=[0.1,0.5];
figure
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,300);
plot(V_adiab,T_adaib)
hold on

[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,350);
plot(V_adiab,T_adaib)
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,400);
plot(V_adiab,T_adaib)
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,450);
plot(V_adiab,T_adaib)
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,500);
plot(V_adiab,T_adaib)
hold off
xlabel('Volume')
ylabel('Temperature')



%adiabatic ode (P-V curve)
figure
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,300);
plot(V_adiab,P(V_adiab,300))
hold on
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,350);
plot(V_adiab,P(V_adiab,350))
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,400);
plot(V_adiab,P(V_adiab,400))
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,450);
plot(V_adiab,P(V_adiab,450))
hold off
xlabel('Volume')
ylabel('Pressure')


%P-V work for adiabatic process

V_span=linspace(0.1,0.3,100);
[V_adiab,T_adaib]=ode45(@(V,T) dT_dV(V,T),V_span,300);
P0=P(V_adiab,300);
A1=trapz(V_span,P0)

%P-V work for isothermal process
V1=linspace(0.1,0.3,100);
P1=P(V1,300);
A2=trapz(V1,P1)


%PLOT FOR ISOTHERMAL AND ADIABATIC PROCESS
V3 = linspace(0.1,0.3,100);
figure
hold on
plot(V3,P(V3,300));
[V_adiab,T_adaib]=ode45(@(V3,T) dT_dV(V3,T),V3,300);
plot(V_adiab,P(V_adiab,300))
hold off
xlabel('Volume')
ylabel('Pressure')