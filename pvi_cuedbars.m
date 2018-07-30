function pvi_cuebars2(data)

avgs = mean(data,1);

pelletx = [1, 2, 3];
infx = [5, 6, 7];

pelletCol = [2, 4, 6];
infCol = [3, 5, 7];

pvi_colors;;

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTick',[],'TickDir','out');
xlim(axes1,[0 8]);
ylim(axes1,[-5 30]);
hold(axes1,'all');

% Create bars
hold on

bar(pelletx,avgs(pelletCol),'FaceColor',pvi_colors_mat(1,:));
bar(infx,avgs(infCol),'FaceColor',pvi_colors_mat(2,:));

% % Create scatters

for i = 1:7
    plot(pelletx,data(i,pelletCol),'-o','MarkerEdgeColor',[0 0 0],'MarkerSize',2);
    plot(infx,data(i,infCol),'-o','MarkerEdgeColor',[0 0 0],'MarkerSize',2);
end

% reshape graph
set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [300 400 120 150])