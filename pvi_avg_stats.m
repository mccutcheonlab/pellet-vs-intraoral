clear all; close all

loadfile = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\Extracted Matlab data\allpvi'

[trialavgs trialall] = voltanalysis_pvi(loadfile,3,1,1,'All rats');

%% for placing data in epochs
Uncued_BL = squeeze(mean(trialall(91:100,:,3:5)));
Uncued_Reward = squeeze(mean(trialall(101:130,:,3:5)));

Cued_BL = squeeze(mean(trialall(91:100,:,1:2)));
Cued_Cue = squeeze(mean(trialall(101:110,:,1:2)));
Cued_Reward = squeeze(mean(trialall(131:140,:,1:2)));

%% assemble data for stats in SPSS

%uncued trials
spssUncuedEpochs = nans(7,7);
spssUncuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssUncuedEpochs(:,2:7) = cat(2,Uncued_BL, Uncued_Reward);

%cued trials
spssCuedEpochs = nans(7,7);
spssCuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssCuedEpochs(:,2:7) = cat(2,Cued_BL, Cued_Cue, Cued_Reward);


pvi_uncuedbars(spssUncuedEpochs)
pvi_cuedbars(spssCuedEpochs)


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
