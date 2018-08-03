function [a, p] = roc_pvi(loadfile, bins)

% for ROC analysis of PVI data
load(loadfile)
pvi_cols;
pvi_colors;

%% to compare core and shell for different trial types

Lselect = x(:,R_noise)~=1; % gets rid of noise

Lcore = x(:,R_region) == 1;
Lshell = x(:,R_region) == 2;

[a, p] = deal(nans(bins,4)); %matrices for roc values and binned data
colors = {red, blue, yellow, green};
trialtypes = {'cued pellet', 'cued infusion', 'probe pellet', 'probe infusion'};

for i = 1:4 % for different trial types
    
    Ltrial = x(:,R_trialtype) == i;
    
    core = s(Lselect & Lcore & Ltrial,51:200);
    shell = s(Lselect & Lshell & Ltrial,51:200);
    
    coredims = [size(core,1) size(core,2)/bins bins];
    shelldims = [size(shell,1) size(shell,2)/bins bins];
    
    core_bins = squeeze(mean(reshape(core,coredims),2));
    shell_bins = squeeze(mean(reshape(shell,shelldims),2));
    
    pvi_roctraces(core_bins, shell_bins, colors{i}, i*200)
    
    [a(:,i) p(:,i)] = nanroc(core_bins,shell_bins, 100, 4, 250);
    
    pvi_rocvalsfig(a(:,i), p(:,i), trialtypes{i}, i*200);
    
end




