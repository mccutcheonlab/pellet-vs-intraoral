%% outputs averaged and rich data using specified inputs

function [avgdata, alldata] = voltanalysis_pvi(loadfile,region,adjBL)

%region: core=1, shell=2, all regions=3, all regions+latency exclusions=4
%analysis: 'trial'=trial by trial

%% loads all data and column names
load(loadfile);
pvi_cols; %loads column names

%% works out which regions to include and filters noisy trials out
if region == 3;
    Lselect = x(:,R_noise)~=1;
elseif region == 4;
    Lselect = x(:,R_noise)~=1 & x(:,R_latency) >= -0.001 & x(:,R_latency) < 3;
else
    Lselect = x(:,R_noise)~=1 & x(:,R_region) == region;
end

%% decides whether to adjust baselines
if adjBL == 1
    s = adj_baseline(s,100,50,1);
end

%individual rat analysis

rats = unique(x(:,R_rat)); % determines rat numbers
[a b] =size(s); % determines trial length
[pelletcue, infcue, probep, probeinf, dummy] = deal(nans(length(rats), b)); % creates empty matrices for data

for i = 1:length(rats);
    
    Lpelletcue = Lselect & x(:,R_rat) == rats(i) & x(:,R_trialtype)==1;
    Linfcue = Lselect & x(:,R_rat) == rats(i) & x(:,R_trialtype)==2;
    Lprobep = Lselect & x(:,R_rat) == rats(i) & x(:,R_trialtype)==3;
    Lprobeinf = Lselect & x(:,R_rat) == rats(i) & x(:,R_trialtype)==4;
    Ldummy = Lselect & x(:,R_rat) == rats(i) & x(:,R_trialtype)==5;
    
    pelletcue(i,:) = nanmean(s(Lpelletcue,:));
    infcue(i,:) = nanmean(s(Linfcue,:));
    probep(i,:) = nanmean(s(Lprobep,:));
    probeinf(i,:) = nanmean(s(Lprobeinf,:));
    dummy(i,:) = nanmean(s(Ldummy,:));
    
end

%assembles matrix with data from all rats
alldata = cat(3,pelletcue',infcue',probep',probeinf',dummy');

%averages data for all rats
pelletcue_all = nanmean(pelletcue,1);
infcue_all = nanmean(infcue,1);
probep_all = nanmean(probep,1);
probeinf_all = nanmean(probeinf,1);
dummy_all = nanmean(dummy,1);

%assembles into single matrix
all_trials = cat(1,pelletcue_all,infcue_all,probep_all,probeinf_all,dummy_all);

avgdata = all_trials';


