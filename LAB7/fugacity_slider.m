function fugacity_slider()

% create figure & axes
    mainFig = figure('Name','Fugacity Demo','NumberTitle','off');
    ax = axes('Parent', mainFig, ...
              'Units','normalized', ...
              'Position',[0.12 0.30 0.75 0.65]);
% range of a_a 
    a_a_min  = 0.1;
    a_a_max  = 0.45;
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
