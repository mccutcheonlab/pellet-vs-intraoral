function pvi_rocvalsfig(a,p,trialtype,xoffset)

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YTick',[0.3 0.4 0.5 0.6 0.7]); %add for ticks 'XTick',1
ylim(axes1,[0.2 0.8]);
hold(axes1,'all');

plot([0; 0], [0.3; 0.7], '-k'); axis off;

plot(a)

L = p < (0.05/length(p));
sigx = find(p<(0.05/length(p)));
sigy = a(L);

scatter(sigx,sigy,'r');

% title(trialtype);

hold off

set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [100+xoffset 100 180 270])