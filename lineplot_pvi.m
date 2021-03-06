function lineplot_pvi(data,title_pvi)

adj_matrix = data(51:200,:);

pvi_colors; %loads colors for PVI trial types

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTickLabel',{'0','5','10','15','20','25','30'},...
    'FontName','arial');
hold(axes1,'all');

% Create multiple lines using matrix input to plot
plot1 = plot(adj_matrix,'LineWidth',4,...
    'Color',[0.501960813999176 0.501960813999176 0.501960813999176],...
    'Parent',axes1);
set(plot1(1),'DisplayName','pellet_cue',...
    'Color',red);
set(plot1(2),'DisplayName','inf_cue',...
    'Color',blue);
set(plot1(3),'DisplayName','probe_pellet',...
    'Color',yellow);
set(plot1(4),'DisplayName','probe_inf',...
    'Color',green);
set(plot1(5),'DisplayName','dummy',...
    'Color',grey);

% Create xlabel
xlabel('time (s)','HorizontalAlignment','right','FontName','arial');

% Create ylabel
ylabel('dopamine (nM)','FontName','arial','HorizontalAlignment','left');

title(title_pvi);


