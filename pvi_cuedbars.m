function pvi_cuedbars(data)

avgs = mean(data,1);

pelletx = [1, 2, 3];
infx = [5, 6, 7];

pelletCol = [2, 4, 6];
infCol = [3, 5, 7];

pvi_colors;

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTick',[],'TickDir','out');
xlim(axes1,[0 8]);
ylim(axes1,[-1 28]);
hold(axes1,'all');

% Create bars
hold on

bar(pelletx,avgs(pelletCol),'FaceColor',red_lt);
bar(infx,avgs(infCol),'FaceColor',blue_lt);

% % Create scatters

sc_color = {'w', 'w', 'w', almost_black, 'w', almost_black, almost_black};

for i = 1:7
    plot(pelletx,data(i,pelletCol),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerFaceColor',sc_color{i},'MarkerSize',5);
    plot(infx,data(i,infCol),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerFaceColor',sc_color{i},'MarkerSize',5);
end

% reshape graph
set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [900 800 157 197])