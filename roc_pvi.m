%% for ROC analysis of PVI data

clear all
setpath
load allpvi
pvi_cols;

%% to compare core and shell for different trial types

Lselect = x(:,R_noise)~=1; % gets rid of noise

Lcore = x(:,R_region) == 1;
Lshell = x(:,R_region) == 2;

a = nans(20,4); %matrix for roc values
p = nans(20,4); %matrix for p vals

for i = 1:4 % for different trial types
    
Ltrial = x(:,R_trialtype) == i;

core = s(Lselect & Lcore & Ltrial,:);
shell = s(Lselect & Lshell & Ltrial,:);

core_bins = squeeze(mean(reshape(core,[],10,20),2)); %plot(mean(core_bins))
shell_bins = squeeze(mean(reshape(shell,[],10,20),2));
plot(mean(shell_bins))

[a(:,i) p(:,i)] = nanroc(core_bins,shell_bins);
end

%% loads color maps
load blu_red.prn
load pvals.prn

%reshaping a and p to align to reward delivery
a_rew = [a(6:end,1:2) a(3:17,3:4)];
p_rew = [p(6:end,1:2) p(3:17,3:4)];

%pads a and p to give full range in pcolor figures
a_rew(:,5) = 0; a_rew(16,:) = 0;
p_rew(:,5) = 0; p_rew(16,:) = 0;

figure;
h(1) = pcolor(a_rew');
colormap(blu_red)
caxis([0.25 0.75])

figure
h(2) = pcolor(p_rew');
colormap(pvals)
caxis([0.0 1.0])


