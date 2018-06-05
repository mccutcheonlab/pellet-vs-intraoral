function PVI_coreshell(data,color,trialtype)

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTickLabel',{'0','5','10','15','20','25','30'},...
    'FontName','arial');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(data,'LineWidth',4,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176],...
    'Parent',axes1);
set(plot1(1),'DisplayName','core',...
    'Color',color);
set(plot1(2),'DisplayName','shell',...
    'Color',[0 1 0]);
% Create xlabel
xlabel('time (s)','HorizontalAlignment','right','FontName','arial');

% Create ylabel
ylabel('dopamine (nM)','FontName','arial','HorizontalAlignment','left');

title(trialtype);


