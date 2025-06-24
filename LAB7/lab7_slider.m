clear
a_a=0.2;
fugacity_slider

function plot_fugacity_mixture(a_a,ax)
hold(ax,'on');

a_b = 0.3 ;
b_a = 0.00004 ;
b_b = 0.00003;
y_aii=[0.2,0.5,0.8,1];

T=300;%K
R=8.314;
for j=1:4
 y_a=y_aii(j);
 y_b=1-y_a;
 a_mix=y_a^2*a_a + 2*y_a*y_b*sqrt(a_a*b_b)+y_b^2*a_b;
b_mix=y_a*b_a+y_b*b_b;
 phi_a=zeros(1,50);

for i=1:50

 myfun = @(v,P) (P+a_mix/(v*v))*(v-b_mix)-R*T;
 P=i*10^5;
fun = @(v) myfun(v,P);
vo=[b_mix+1e-10,100000];
v = fzero(fun,vo);
phi_a(i)= exp(-log(P*(v-b_mix)/(R*T))+b_a/(v-b_mix)-2*(y_a*a_a+y_b*sqrt(a_a*a_b))/(R*T*v));
end
disp(phi_a)
figure(1)
P__=linspace(1,50,50);
plot(P__,phi_a,'-');
xlabel('Pressure');
ylabel('phi_a');
legend('y_a=0.2','y_a=0.5','y_a=0.8','y_a=1');
title('φ_a as a function of pressure');
grid on
hold on
end

end

function fugacity_slider()
% create figure & axes
 mainFig = figure('Name','Fugacity Demo','NumberTitle','off');
 ax = axes('Parent', mainFig, ...
 'Units','normalized', ...
 'Position',[0.12 0.30 0.75 0.65]);
% range of a_a
 a_a_min = 0.1;
 a_a_max = 0.45;
 a_a_init = 0.2;

% create the slider and position it at the bottom of the figure
 sld = uicontrol('Parent', mainFig, 'Style','slider', ...
 'Min',a_a_min, 'Max',a_a_max, 'Value',a_a_init, ...
 'Units','normalized', 'Position',[0.15 0.05 0.70 0.05], ...
 'Callback', @(src,~) redrawPlot(src.Value) );

% plot once at the initial slider value
 redrawPlot(a_a_init);

% function to redraw the plot as the value of a_a is changed

 function redrawPlot(a_a)
 % clear the current axes
 cla(ax);
 plot_fugacity_mixture(a_a, ax)
 title(ax, sprintf('Fugacity of a vs P (slider), a_a = %.2f', a_a));
 drawnow;
 end
end