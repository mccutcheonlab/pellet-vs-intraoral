%% analyzes PVI data set using other programs

clear all
% setpath

%% works out core and shell averages using voltanalysis

% core = voltanalysis_pvi(1,'trial','core, trial-by-trial');
% shell = voltanalysis_pvi(2,'trial','shell, trial-by-trial');

[core_avg core_all] = voltanalysis_pvi(1,'rat','core, rat-by-rat');
[shell_avg shell_all] = voltanalysis_pvi(2,'rat','shell, rat-by-rat');

[all_avg all_alldata] = voltanalysis_pvi(3,'rat','all, rat-by-rat');

% for when nanmean is unavailable
% core_avg = squeeze(mean(core_all(:,1:4,:),2));
% shell_avg = squeeze(mean(shell_all(:,5:8,:),2));
% both = voltanalysis_pvi(3,'rat','all regions, rat-by-rat');

%% makes and saves heatmaps

% heatmap_pvi(core_avg)
% a = gcf;
% printfile = 'core_heatmap';
% print(a,printfile,'-dpdf');
% heatmap_pvi(shell_avg);
% a = gcf;
% printfile = 'shell_heatmap';
% print(a,printfile,'-dpdf');

%% this is re-aligning avgs to reward delivery

% Not sure whether these lines are necessary
%
% data = core_avg;
% data = cat(2,data(51:200,1:2),data(21:170,3:4));
% 
% data = shell_avg;
% data = cat(2,data(51:200,1:2),data(21:170,3:4));
% 
% cueDA = nans(8,2);
% cueDA(1:4,:) = squeeze(mean(core_all(100:129,1:4,1:2),1));
% cueDA(5:8,:) = squeeze(mean(shell_all(100:129,5:8,1:2),1));

