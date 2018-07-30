%% outputs averaged and rich data using specified inputs

function [avgdata, alldata] = voltanalysis_pvi(loadfile,region,analysis,title_pvi)

%region: core=1, shell=2, all regions=3, all regions+latency exclusions=4
%analysis: 'trial'=trial by trial

%% loads all data and column names

load(loadfile)
pvi_cols; %loads column names
setpath; %sets paths for loading and saving appropriate for diff computers

%% works out which regions to include and filters noisy trials out
if region == 3;
    Lselect = x(:,R_noise)~=1;
elseif region == 4;
    Lselect = x(:,R_noise)~=1 & x(:,R_latency) >= -0.001 & x(:,R_latency) < 3;
else
    Lselect = x(:,R_noise)~=1 & x(:,R_region) == region;
end

%to 

%% works out whether to analyze by rat or by trial

if strcmp(analysis,'trial') == 1;
    
    %individual trial analysis
    %creates Logical indexes for each trial
    Lpelletcue = x(:,R_trialtype)==1 & Lselect;
    Linfcue = x(:,R_trialtype)==2 & Lselect;
    Lprobep = x(:,R_trialtype)==3 & Lselect;
    Lprobeinf = x(:,R_trialtype)==4 & Lselect;
    Ldummy = x(:,R_trialtype)==5 & Lselect;
    
    %averages all trials of each type together
    pelletcue = nanmean(s(Lpelletcue,:));
    infcue = nanmean(s(Linfcue,:));
    probep = nanmean(s(Lprobep,:));
    probeinf = nanmean(s(Lprobeinf,:));
    dummy = nanmean(s(Ldummy,:));
    
    %concatenates into single matrix
    all_trials = cat(1,pelletcue,infcue,probep,probeinf,dummy);
    
else
    
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
        
        
        %comment out to prevent making individual graphs
%         if ~isnan(pelletcue(i,:));
%             forgraph = cat(2,pelletcue(i,:)',infcue(i,:)',probep(i,:)',probeinf(i,:)',dummy(i,:)');
%             lineplot_pvi(forgraph,strcat('pvi_',num2str(rats(i))));
%             a = gcf;
%             printfile = strcat(masterpath2,'\Dropbox\MATLAB\Experiments\PVI\figs\pvi',num2str(rats(i)));
%             print(a,printfile,'-dpdf');
%         end
        
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
    
end

avgdata = all_trials';
lineplot_pvi(avgdata,title_pvi);


