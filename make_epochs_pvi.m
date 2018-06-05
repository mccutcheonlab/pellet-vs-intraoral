%% make epochs: for dividing dopamine data into distinct epochs

clear all
setpath;
load allpvi;

%% works out core and shell averages using voltanalysis

% core = voltanalysis_pvi(1,'trial','core, trial-by-trial');
% shell = voltanalysis_pvi(2,'trial','shell, trial-by-trial');

[core_avg core_all] = voltanalysis_pvi(1,'rat','core, rat-by-rat');
[shell_avg shell_all] = voltanalysis_pvi(2,'rat','shell, rat-by-rat');

[all_avg all_alldata] = voltanalysis_pvi(3,'rat','all, rat-by-rat');

%% resizes data so reward epoch is aligned

data = cat(3,all_alldata(51:200,:,1:2),all_alldata(21:170,:,3:5));

%% 
[a,b,c] = size(data);
pvi_epoch = nans(b,3,c);

pvi_epoch(:,1,:) = mean(data(1:50,:,:),1);
pvi_epoch(:,2,:) = mean(data(51:80,:,:),1);
pvi_epoch(:,3,:) = mean(data(81:146,:,:),1);

pvi_epoch_x = squeeze(mean(pvi_epoch,1));

pvi_epoch_core = pvi_epoch([core_rats],:,:);
pvi_epoch_shell = pvi_epoch([shell_rats],:,:);

pvi_epoch_corex = squeeze(mean(pvi_epoch_core,1));
pvi_epoch_shellx = squeeze(mean(pvi_epoch_shell,1));
