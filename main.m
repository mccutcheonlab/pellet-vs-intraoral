%% Script to assemble_rat_data

% ADD PATH TO DATA 
masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\';

assembledata = 0; % change to assemble data from raw data files
plotrepresentativedata = 0; % change to plot rep data

%% Checks value of assembledata and to determine whether to extract from raw data
if assembledata == 1;
    % Extracts all data for individual rats
    
    extractdata(masterfolder, 'pvi08', 8, 120925, 1, '!2012-09-25_12h43m.Subject PVI8', 263.276);
    extractdata(masterfolder, 'pvi09', 9, 120926, 1, '!2012-09-26_11h23m.Subject PVI9', 472.082);
    extractdata(masterfolder, 'pvi10', 10, 120927, 1, '!2012-09-27_13h54m.Subject PVI10', 475.669);
    extractdata(masterfolder, 'pvi12', 12, 121129, 2, '!2012-11-29_13h47m.Subject PVI12', 491.02);
    extractdata(masterfolder, 'pvi15', 15, 121218, 1, '!2012-12-18_11h00m.Subject PVI15', 1359.28);
    extractdata(masterfolder, 'pvi16', 16, 121218, 2, '!2012-12-18_15h02m.Subject PVI16', 159.653);
    extractdata(masterfolder, 'pvi18', 18, 121219, 2, '!2012-12-19_12h48m.Subject PVI18', 138.501);

    % Combines data into single matrix for further analysis
    pvi_cols; %loads column names for x matrix
    loadfolder = strcat(masterfolder, 'Extracted Matlab data\');

    % Loads rat data
    load(strcat(loadfolder,'pvi08'));
    load(strcat(loadfolder,'pvi09'));
    load(strcat(loadfolder,'pvi10'));
    load(strcat(loadfolder,'pvi12'));
    load(strcat(loadfolder,'pvi15'));
    load(strcat(loadfolder,'pvi16'));
    load(strcat(loadfolder,'pvi18'));

    % Combines into single x and s matrices
    x = cat(1, pvi08_x, pvi09_x, pvi10_x, pvi12_x, pvi15_x, pvi16_x, pvi18_x);
    s = cat(1, pvi08_s, pvi09_s, pvi10_s, pvi12_s, pvi15_s, pvi16_s, pvi18_s);

    % Assigns rats to core or shell
    core_rats = [1 2 3 5];
    shell_rats = [4 6 7];

    % Saves allpvi file
    save(strcat(loadfolder, 'allpvi'), 'x', 's',...
        'core_rats', 'shell_rats');
end

%% Analysis of PVI data set using data in allpvi

loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

% For representative plots
if plotrepresentativedata == 1
    pvi_reptraces(loadfile, 8, [1 2 3 4 5]);
end

% Works out averages using voltanalysis and makes average plots
[all_avg all_trials] = voltanalysis_pvi(loadfile,3,1);

% Places data in epochs
Uncued_BL = squeeze(mean(all_trials(91:100,:,3:5)));
Uncued_Reward = squeeze(mean(all_trials(101:130,:,3:5)));

Cued_BL = squeeze(mean(all_trials(91:100,:,1:2)));
Cued_Cue = squeeze(mean(all_trials(101:110,:,1:2)));
Cued_Reward = squeeze(mean(all_trials(131:140,:,1:2)));

% Assembles average epoch data into simple matrices for stats in SPSS

% Uncued trials
spssUncuedEpochs = nans(7,7);
spssUncuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssUncuedEpochs(:,2:7) = cat(2,Uncued_BL, Uncued_Reward);

% Cued trials
spssCuedEpochs = nans(7,7);
spssCuedEpochs(:,1) = [8; 9; 10; 12; 15; 16; 18];
spssCuedEpochs(:,2:7) = cat(2,Cued_BL, Cued_Cue, Cued_Reward);

% Makes line graphs for each trial type
pvi_avgtraces_uncued(all_trials)
pvi_avgtraces_cued(all_trials)

% Makes bar graphs for epochs
pvi_uncuedbars(spssUncuedEpochs)
pvi_cuedbars(spssCuedEpochs)

%% To make Figure 2 - ROC analysis of different regions 

loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

[rocvals rocp] = roc_pvi(loadfile, 30);
