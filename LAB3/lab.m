clc
clear all
close all
%DEFINE THE MATRIX
N=5;
A=[ones(N),zeros(N)];
figure
imagesc(A);
axis equal tight;

% Pre-define array to record the number of 1s in the left N x N block at
% each step.It records the number of atoms in excited state in left chamber

leftCount = zeros(2000, 1);
plotinterval=1;

for i=1:2000
    %B=A;
    A=randomswaps(A);

    leftCount(i)=sum(sum(A(:,1:N)));
    
   
    if mod(i,plotinterval)==0
        imagesc(A);
        axis equal tight
        title('steps',i)
        drawnow
    end
end

%%evolution of the fraction of atoms in
%%the excited state in the left chamber as a function of simulation step
%%number
figure
x=linspace(1,2000,2000);
plot(x,leftCount);
title('fraction of excited numbers of atoms in left chamber');
xlabel('steps');
ylabel('fraction of excited atoms');
%%histogram
figure
histogram(leftCount(1000:end)/N^N);
title('franction of atom excited in left chamber');
%%mean and variance
mean=mean(leftCount);
disp(mean);
variance=var(leftCount);
disp(variance);
%%part6
