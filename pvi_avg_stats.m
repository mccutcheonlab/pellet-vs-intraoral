clear all; close all

[testavg testall] = voltanalysis_pvi(3,'rat','All rats');

% clear all -EXCEPT 'testavg' 'testall'

adj_matrix = nans(150,7,5);
adj_matrix(:,:,1:2) = testall(51:200,:,1:2);
adj_matrix(:,:,3:5) = testall(21:170,:,3:5);


%% for testing shorter reward epochs (1s)
baselineCued = squeeze(mean(adj_matrix(41:50,:,1:2)));
baselineUncued = squeeze(mean(adj_matrix(21:50,:,3:5)));
cue = squeeze(mean(adj_matrix(51:60,:,1:2)));
rewardCued = squeeze(mean(adj_matrix(81:90,:,1:2)));
rewardUncued = squeeze(mean(adj_matrix(81:110,:,3:5)));

%% for stats for SPSS

%cued trials
spssCuedEpochs = nans(7,7);
spssCuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssCuedEpochs(:,2:7) = cat(2,baselineCued, cue, rewardCued);

%uncued trials
spssUncuedEpochs = nans(7,7);
spssUncuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssUncuedEpochs(:,2:7) = cat(2,baselineUncued, rewardUncued);

%% for testing medium epochs (3s)
% baseline = squeeze(mean(adj_matrix(21:50,:,:)));
% cue = squeeze(mean(adj_matrix(51:80,:,:)));
% reward = squeeze(mean(adj_matrix(81:110,:,:)));

%% removes each rats' individual baseline
% cue_adj = cue - baseline;
% reward_adj = reward - baseline;
% 
% % removes average baseline - I prefer subtraction of individual baselines
% cue_adj2 = bsxfun(@minus,cue,mean(baseline,1));
% reward_adj2 = bsxfun(@minus,reward,mean(baseline,1));

% pvi_fig2(baseline)
% pvi_fig2(cue_adj2)
% pvi_fig2(cue_adj)
% pvi_fig2(reward_adj)

% pvi_cuebars(cue_adj,reward_adj)
% 
% pvi_uncuedbars(reward_adj)

%should test this out and make sure it corresponds to real data!
%look into pellet trial with high baseline
%repeated measures or not? not all groups are relevant so maybe simpler
%tests are better

%first test and figure
%bar/scatter for baseline with one way ANOVA

%second test and figure
%bar/scatter for cue (with only three groups)
% 
% [h p] = ttest(cue(:,1),cue(:,2))
% 
% [h p] = ttest(reward(:,1),reward(:,2))


%For 2-way within subjects stats for cued trials (change from baseline)
Y = [cue_adj(:,1);cue_adj(:,2);reward_adj(:,1);reward_adj(:,2)]; %dependent variable
S = repmat([8; 9; 10; 12; 15; 16; 18],4,1); %Grouping var for subject
F1 = repmat([ones(7,1);2*ones(7,1)],2,1);
F2 = [ones(14,1);2*ones(14,1)];
FACTNAMES = cell({'TRIALTYPE','EPOCH'});

stats = rm_anova2(Y,S,F1,F2,FACTNAMES)

%For 2-way within subjects stats for cued trials INCLUDING BASELINE
Y = [baseline(:,1); baseline(:,2); cue(:,1);cue(:,2);reward(:,1);reward(:,2)]; %dependent variable
S = repmat([8; 9; 10; 12; 15; 16; 18],6,1); %Grouping var for subject
F1 = repmat([ones(7,1);2*ones(7,1)],3,1);
F2 = [ones(14,1);2*ones(14,1);3*ones(14,1)];
FACTNAMES = cell({'TRIALTYPE','EPOCH'});

stats = rm_anova2(Y,S,F1,F2,FACTNAMES)

%To structure stats for SPSS
spssEpochs = nans(7,7);
spssEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssEpochs(:,2:7) = cat(2,baseline(:,1:2), cue(:,1:2), reward(:,1:2));

%to make figure including baseline

pvi_cuebars2(spssEpochs)
pvi_cuebars3(spssCuedEpochs)


%For 2-way within-subjects stats for uncued trials INCLUDING BASELINE
Y = [baseline(:,3); baseline(:,4); baseline(:,5); reward(:,3);reward(:,4); reward(:,5)]; %dependent variable
S = repmat([8; 9; 10; 12; 15; 16; 18],6,1); %Grouping var for subject
F1 = repmat([ones(7,1);2*ones(7,1);3*ones(7,1)],2,1);
F2 = [ones(21,1);2*ones(21,1)];
FACTNAMES = cell({'TRIALTYPE','EPOCH'});

stats = rm_anova2(Y,S,F1,F2,FACTNAMES)

%To structure stats for SPSS
spssEpochs = nans(7,7);
spssEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssEpochs(:,2:7) = cat(2,baseline(:,3:5), reward(:,3:5));

pvi_uncuedbars3(spssUncuedEpochs)
