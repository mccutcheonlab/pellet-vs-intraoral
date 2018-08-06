function prob_approach_fig(approach_data)

approach_mean = mean(approach_data);
pvi_colors;

figure2 = figure;

axes1 = axes('Parent',figure2,'XTick',[],'TickDir','out');
xlim(axes1,[0 3]);
ylim(axes1,[0 1.05]);

hold(axes1,'all');

hold on

xvals = [1 2];

bar(xvals(1),approach_mean(1),'FaceColor',red_lt);
bar(xvals(2),approach_mean(2),'FaceColor',blue_lt);

for i = 1:size(approach_data,1)
    plot(xvals,approach_data(i,:),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerSize',2);
end

% reshape graph
set(gca, 'Ytick', [0.25 0.5 0.75 1]);

set(gca, 'Ytick', [0 0.5 1]);

set(gca,'color','none'); %removes white b/ground
set(gcf, 'Position', [900 800 120 150]);
