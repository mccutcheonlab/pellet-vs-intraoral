%% to make histograms and binned data for statistical testing
clear all
setpath;
load allpvi;

%% generates matrices for core and shell using voltanalysis
[core_avg, core_all] = voltanalysis_pvi(1,'rat','core, rat-by-rat');
[shell_avg, shell_all] = voltanalysis_pvi(2,'rat','shell, rat-by-rat');
[all_avg, all_data] = voltanalysis_pvi(3,'rat','all, rat-by-rat');

%% puts all data into single matrix
% all_data = cat(2,core_all(:,core_rats,:),shell_all(:,shell_rats,:));

%% provides parameters for binning
[a, b, c] = size(all_data); %a=time points, b=rats, c=trial types
div = 1; %bin size in seconds
bins = (a/10)/div; %no. of bins
ndata = a/bins; %no. of data points per bin
binned = nans(bins,b,c); %creates matrix for binned data

%% bins data appropriately
for i = 1:b; %for each rat
    for j = 1:c %for each trial type
        y = all_data(:,i,j);
        binned(:,i,j) = mean(reshape(y, [ndata, bins]))';
    end
end

%% 
x_bar = div:div:20; %creates x-axis scale

%to reshape so reward is at +8s in all
lim12 = [(find(x_bar ==5) + 1) (find(x_bar == 20))];
lim345 = [(find(x_bar ==2) + 1) (find(x_bar == 17))];
x_bar = x_bar(lim12(1):lim12(2));

%concatenates binned histograms so they line up, e.g. reward = 8s
binned = cat(3,binned(lim12(1):lim12(2),:,1:2),binned(lim345(1):lim345(2),:,3:5));

%% makes means and errors of core and shell
core_bar = squeeze(mean(binned(:,core_rats,:),2)); %need to update if core/shell changes
[core_bar_sem_u, core_bar_sem_l] = deal(squeeze(std(binned(:,core_rats,:),1,2)));
Lselect = core_bar > 0;
core_bar_sem_u(Lselect) = 0;
core_bar_sem_l(~Lselect) = 0;

shell_bar = squeeze(mean(binned(:,shell_rats,:),2)); %need to update if core/shell changes
[shell_bar_sem_u, shell_bar_sem_l] = deal(squeeze(std(binned(:,shell_rats,:),1,2)));
Lselect = shell_bar > 0;
shell_bar_sem_u(Lselect) = 0;
shell_bar_sem_l(~Lselect) = 0;

%% makes and saves bar graphs
pvi_colors; %loads pvi colors
trials = {'pelletcue', 'infcue', 'probepellet', 'probeinf', 'dummy'};
region='core_';
for i =1:5
y = core_bar(:,i);
u = core_bar_sem_u(:,i);
l = core_bar_sem_l(:,i);
errorbar_pvi(x_bar,y,u,l,pvi_colors_mat(i,:));
a = gcf;
printfile = strcat(masterpath2,'\Dropbox\MATLAB\Experiments\PVI\bars\',region,trials{i});
print(a,printfile,'-depsc');
end

region='shell_';
for i =1:5
y = shell_bar(:,i);
u = shell_bar_sem_u(:,i);
l = shell_bar_sem_l(:,i);
errorbar_pvi(x_bar,y,u,l,pvi_colors_mat(i,:));
a = gcf;
printfile = strcat(masterpath2,'\Dropbox\MATLAB\Experiments\PVI\bars\',region,trials{i});
print(a,printfile,'-depsc');
end

%% prepares data for SPSS ANOVAs
ids = nans(7,2);
ids(:,1) = 1:7;
ids(1:3,2) = 1;
ids(4:7,2) = 2;
binned_stats = cat(1,binned(:,:,1),binned(:,:,2),binned(:,:,3),...
    binned(:,:,4),binned(:,:,5))';
binned_stats = cat(2,ids,binned_stats);

%% for making matrix for SPSS
[a b c] = size(binned);
spss = nans(a*b*c,4);
spss(:,4) = reshape(binned,[],1);

for i = 1:c
    trialtype(:,:,i) = repmat(i,a,b);
end
spss(:,2) = reshape(trialtype,[],1);

for i = 1:b
    rats(:,i,:) = repmat(i,a,c);
end
spss(:,1) = reshape(rats,[],1);

trialn = [1:15]; % tiles trial number
spss(:,3) = repmat(trialn,1,35);

