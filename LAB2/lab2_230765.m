clear all
clc
N=6.023*1e23;
u=linspace(1,10,100);
v=linspace(1,10,100);
[U,V]=meshgrid(u,v);
%%PROBLEM1 PART1
S1=fundamental1(U,V ,N );
figure
surf(U,V,S1)

S2=fundamental2(U,V ,N );
figure
surf(U,V,S2)

%%PROBLEM PART2
u=linspace(1,10,100);
v=linspace(1,10,100);
[U,V]=meshgrid(u,v);
S1=fundamental1(U,V ,N );
[dS1_dU,dS1_dV]=gradient(S1);
n1=length(dS1_dU);
b1=dS1_dU<0;
sum1=0;
for i=1:length(b1)
    sum1=sum1+b1(i);
end
sum1
n2=length(dS1_dV);
b2=dS1_dV<0;
sum2=0;
for i=1:length(b2)
    sum2=sum2+b2(i);
end
sum2
%we got reasonable values for T and P for fundamental equation1


u=linspace(1,10,100);
v=linspace(1,10,100);
[U,V]=meshgrid(u,v);
S2=fundamental2(U,V ,N );
[dS2_dU,dS2_dV]=gradient(S2);
n1=length(dS2_dU);
b1=dS2_dU<0;
sum1=0;
for i=1:length(b1)
    sum1=sum1+b1(i);
end
sum1
n2=length(dS2_dV);
b2=dS2_dV<0;
sum2=0;
for i=1:length(b2)
    sum2=sum2+b2(i);
end
sum2
%we got reasonable values for T and P for fundamental equation2


%%PROBLEM1_PART3
N=6.023*1e23;
u=linspace(1,10,100);
v=linspace(1,10,100);
[U,V]=meshgrid(u,v);
%%PROBLEM1 PART1
S1=fundamental1(U,V ,N );
M1=max(S1);
lambda=0.7;
S11=fundamental1(lambda*U,lambda*V,lambda*N);
M11=max(S11);
diff1=abs(lambda*M1-M11);
D1=max(diff1)


S2=fundamental2(U,V ,N );
M2=max(S2);
lambda=0.001;
S22=fundamental2(lambda*U,lambda*V,lambda*N);
M22=max(S22);
diff2=abs(lambda*M2-M22);
D2=max(diff2)
%%fundamental equation1 is satisfying the extensivity criteria and
%%fundamenta equation 2 is not satisfying it

%%PROBLEM2_PART1
Ut=10;
Vt=10;
Na=6.023*1e23;
Nb=12.046*1e23;
Uai=4;
Vai=2;
ua=linspace(1,10,100);
va=linspace(1,10,100);
[Ua,Va]=meshgrid(ua,va);
S_gr=fundamental3(Ua,Va,Na)+fundamental3(10-Ua,10-Va,Nb);
figure
surf(Ua,Va,S_gr)

S=@(z)-(fundamental3(z(1),z(2),Na)+fundamental3(10-z(1),10-z(2),Nb));

%%PROBLEM2_PART2
S0=[1,1];
[z_opt,fval]=fminunc(S,S0);
%%Ua=Ua_ans,Ub=Ub_ans,Va=Va_ans;Vb=Vb_ans
Ua_ans=z_opt(1)
Va_ans=z_opt(2)
Ub_ans=10-Ua_ans
Vb_ans=10-Va_ans


