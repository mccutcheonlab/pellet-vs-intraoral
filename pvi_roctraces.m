function pvi_roctraces(core, shell, color, xoffset)

figure()

pvi_colors;
x_ax = [1:size(core,2)];

% Shell ROC data
ymean = mean(core,1);
ysem = std(core) / sqrt(size(core,1));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', color,'markerfacecolor',color});
hold on; plot([5; 5], [10; 15], '-k'); axis off;

% Core ROC data
ymean = mean(shell,1);
ysem = std(shell) / sqrt(size(shell,1));

shadedErrorBar(x_ax,ymean,ysem,{'-','Color', grey, 'markerfacecolor',grey});
hold off

set(gca,'ylim',[-13 21]);
set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [100+xoffset 500 180 180])
