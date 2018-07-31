function pvi_avgtraces_uncued(data)

pvi_colors;
x_ax = [1:150];

% Dummy trial
y = data(51:200,:,5);
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', grey,'markerfacecolor',grey});
hold on; plot([20; 20], [12; 17], '-k'); axis off;

% Probe infusion trial
y = data(51:200,:,4);
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', green,'markerfacecolor',green});
hold on;

% Probe pellet trial
y = data(51:200,:,3);
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', yellow, 'markerfacecolor',yellow});
hold off;

set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [300 400 180 180])





