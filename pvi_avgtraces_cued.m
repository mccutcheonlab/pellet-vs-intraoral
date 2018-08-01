function pvi_avgtraces_cued(data)

figure()

pvi_colors;
x_ax = [1:150];

% Cued infusion trial
y = data(51:200,:,2);
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', blue,'markerfacecolor',blue});
hold on; plot([20; 20], [15; 20], '-k'); axis off;

% Cued pellet trial
y = data(51:200,:,1);
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', red, 'markerfacecolor',red});
hold off

set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [700 800 180 180])
