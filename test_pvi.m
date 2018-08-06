close all

% basic script to show number of noisy trials in different settings
masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\';
loadfile = 'C:\Users\James Rig\Dropbox\MATLAB\Experiments\2013_PVI\data\allpvi';
loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

load(loadfile)
pvi_cols;

s = adj_baseline(s,100,50,1);

Lnoise = x(:,R_noise) ~= 1;

Lreal = x(:,R_latency) > -0.0001; % excludes latencies that are set to negative numbers as these represent missed trials
Lapproach = x(:,R_approach) > 0;

rats = unique(x(:,R_rat)); % determines rat numbers

[DA_mean approach_mean latency_mean] = deal(nans(length(rats),1));
trialtypes = {'Cued pellet', 'Cued infusions'};

[DA_approach N_approach] = deal(nans(length(rats),2,2));

for i = 1:length(rats)
    for j = 1:length(trialtypes)
        Ltrial = x(:,R_trialtype) == j;
        Lrat = x(:,R_rat) == rats(i);
        L = Lrat & Lnoise & Ltrial;
        DApeaks = mean(s(L,101:130),2);
        
        % for plots of individual rats
%         figure()
%         ax1 = subplot(1,2,1);
%         scatter(x(L,R_approach),DApeaks);
%         ylim([-20 60]);
%         ylabel('DA peak (1s)');
%         xlabel('Approach (ms)');
%         title(strcat('PVI', num2str(rats(i))));
%         
%         ax2 = subplot(1,2,2);
%         scatter(x(L,R_latency),DApeaks);
%         ylim([-20 60]);
%         xlabel('Latency (s)');
        
        DA_mean(i) = mean(DApeaks);
        approach_mean(i) = mean(x(L,R_approach));
        latency_mean(i) = mean(x(L,R_latency));
        
        L = Lrat & Lnoise & Ltrial & ~Lapproach; %trials with no approach
        DA_approach(i,1,j) = mean(mean(s(L,101:130),2));
        N_approach(i,1,j) = sum(L);
        L = Lrat & Lnoise & Ltrial & Lapproach; %trials with approach
        DA_approach(i,2,j) = mean(mean(s(L,101:130),2));
        N_approach(i,2,j) = sum(L);

    end
end
% 
% figure()
% ax1 = subplot(1,2,1);
% scatter(approach_mean,DA_mean);
% ylabel('DA peak (1s)');
% xlabel('Approach (ms)');
% title('Mean of each rat');
% 
% ax2 = subplot(1,2,2);
% scatter(latency_mean,DA_mean);
% ylim([-20 60]);
% xlabel('Latency (s)');

% Making figure for approach behaviour vs dopamine
figure1 = figure;

pellet_approach = removenanrows(DA_approach(:,:,1));
inf_approach = removenanrows(DA_approach(:,:,2));

pellet_avgs = mean(pellet_approach);
inf_avgs = mean(inf_approach);

pelletx = [1, 2];
infx = [4, 5];

pelletCol = [2, 4, 6];
infCol = [3, 5, 7];

pvi_colors;

axes1 = axes('Parent',figure1,'XTick',[],'TickDir','out');
xlim(axes1,[0 6]);
ylim(axes1,[-1 40]);
hold(axes1,'all');

% Create bars
hold on

bar(pelletx,pellet_avgs,'FaceColor',red_lt);
bar(infx,inf_avgs,'FaceColor',blue_lt);

% % Create scatters

for i = 1:size(pellet_approach,1)
    plot(pelletx,pellet_approach(i,:),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerSize',2);
end

for i = 1:size(pellet_approach,1)
    plot(infx,inf_approach(i,:),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerSize',2);
end

% reshape graph
set(gca,'color','none') %removes white b/ground
set(gcf, 'Position', [900 800 120 150])



probability_approach = squeeze(N_approach(:,2,:) ./ sum(N_approach,2))

figure2 = figure;

approach_mean = mean(probability_approach)

axes1 = axes('Parent',figure2,'XTick',[],'TickDir','out');
xlim(axes1,[0 3]);
ylim(axes1,[0 1.05]);

hold(axes1,'all');

hold on

xvals = [1 2];

bar(xvals(1),approach_mean(1),'FaceColor',red_lt)
bar(xvals(2),approach_mean(2),'FaceColor',blue_lt)

for i = 1:size(probability_approach,1)
    plot(xvals,probability_approach(i,:),'-o','Color',grey,'MarkerEdgeColor',almost_black,'MarkerSize',2);
end

% reshape graph
set(gca, 'Ytick', [0.25 0.5 0.75 1]);

set(gca, 'Ytick', [0 0.5 1]);

set(gca,'color','none'); %removes white b/ground
set(gcf, 'Position', [900 800 120 150]);

% Lnoise = x(:,R_noise) ~= 1;
% Lrat = x(:,R_rat) == 10;
% 
% 
% L = Lnoise & Lrat & Ltrial;
% sum(L)
% 
% pvi10_probeinfs = s(L,:);
% 
% pvi10_probeinfs_adj = adj_baseline(pvi10_probeinfs, 100, 50, 1);
% 
% 
% 
% extractdata(masterfolder, 'pvi10', 99, 999999, 9, '!2012-09-27_13h54m.Subject PVI10', 475.669)





% 
% Lnoise = x(:,R_noise) == 1;
% 
% rats = unique(x(:,R_rat)); % determines rat numbers
% 
% for i = 1:length(rats)
%     Lrat = x(:,R_rat) == rats(i);
%     L = Lrat & Lnoise;
%     for j = 1:5
%         Ltrial = x(:,R_trialtype) == j;
%         L = Lrat & Lnoise & Ltrial;
%         strcat('PVI', num2str(rats(i)), ' - ', num2str(sum(L)))
%     end
% end
% 
% extractdata(masterfolder, ratname, ratnumber, date, region, behavfile, Qa)
% 
% datafolder = strcat(masterfolder, 'Raw data and snipped trials\', 'pvi18', '\');
% Qa=138.501
% noise.pelletcue = noiseQa(strcat(datafolder,'01_pelletcue\BATCH_PC'),Qa,[51:200]);
