%% Script to assemble_rat_data

masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\'

%% Extracts all data for individual rats
extractdata('pvi08', 8, 120925, 1, '!2012-09-25_12h43m.Subject PVI8', 263.276)
extractdata('pvi09', 9, 120926, 1, '!2012-09-26_11h23m.Subject PVI9', 472.082)
extractdata('pvi10', 10, 120927, 1, '!2012-09-27_13h54m.Subject PVI10', 475.669)
extractdata('pvi12', 12, 121129, 1, '!2012-11-29_13h47m.Subject PVI12', 491.02)
extractdata('pvi15', 15, 121218, 1, '!2012-12-18_11h00m.Subject PVI15', 1359.28)
extractdata('pvi16', 16, 121218, 2, '!2012-12-18_15h02m.Subject PVI16', 159.653)
extractdata('pvi18', 18, 121219, 2, '!2012-12-19_12h48m.Subject PVI18', 138.501)


%% Combines data into single matrix for further analysis

pvi_cols; %loads columns for pvi expt

loadfolder = strcat(masterfolder, 'Extracted Matlab data\')

% Loads rat data
load(strcat(loadfolder,'pvi08'))
load(strcat(loadfolder,'pvi09'))
load(strcat(loadfolder,'pvi10'))
load(strcat(loadfolder,'pvi12'))
load(strcat(loadfolder,'pvi15'))
load(strcat(loadfolder,'pvi16'))
load(strcat(loadfolder,'pvi18'))

% Combines into single x and s matrices
x = cat(1, pvi08_x, pvi09_x, pvi10_x, pvi12_x, pvi15_x, pvi16_x, pvi18_x);
s = cat(1, pvi08_s, pvi09_s, pvi10_s, pvi12_s, pvi15_s, pvi16_s, pvi18_s);

% Assigns rats to core or shell
core_rats = [1 2 3 5];
shell_rats = [4 6 7];

% Saves allpvi file

save(strcat(loadfolder, 'allpvi'), 'x', 's',...
    'core_rats', 'shell_rats');
