%% Script to assemble_rat_data

% masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\'

%% Extracts all data for individual rats
extractdata('pvi08', 8, 120925, 1, '!2012-09-27_13h54m.Subject PVI10', 225.835)

% extractdata('pvi09', 9, 120926, 1, '!2012-09-26_11h23m.Subject PVI9', 472.082)
% 
% extractdata('pvi10', 10, 120927, 1, '!2012-09-27_13h54m.Subject PVI10', 475.669)
% 
% extractdata('pvi12', 12, 121129, 1, '!2012-11-29_13h47m.Subject PVI12', 491.02)
% 
% extractdata('pvi15', 15, 121218, 1, '!2012-12-18_11h00m.Subject PVI15', 1359.28)
% 
% extractdata('pvi16', 16, 121218, 2, '!2012-12-18_15h02m.Subject PVI16'', 213.765)
% 
% extractdata('pvi18', 18, 121219, 2, '!2012-12-19_12h48m.Subject PVI18', 138.501)


%% Combines data into single matrix for further analysis

% setpath; %sets paths for loading and saving appropriate for diff computers
% pvi_cols; %loads columns for pvi expt

% %% loads rat data
% 
% % load pvi_02 %excluded because run differently - no light cue
% load pvi_08
% load pvi_09
% load pvi_10
% load pvi_12
% load pvi_15
% load pvi_16
% load pvi_18
% 
% % to reshape matrices, can remove if all conc files generated are identical
% % pvi2_s = pvi2_s(:,1:200);
% pvi8_s = pvi8_s(:,1:200);
% pvi9_s = pvi9_s(:,1:200);
% pvi10_s = pvi10_s(:,1:200);
% 
% % to take into account approach measured in 1/10s not ms
% % pvi2_x(:,7) = pvi2_x(:,7)*10;
% 
% % x = cat(1, pvi2_x, pvi8_x, pvi9_x, pvi10_x, pvi12_x, pvi15_x, pvi16_x, pvi18_x);
% % s = cat(1, pvi2_s, pvi8_s, pvi9_s, pvi10_s, pvi12_s, pvi15_s, pvi16_s, pvi18_s);
% 
% 
% %% need to update if more rats added
% x = cat(1, pvi8_x, pvi9_x, pvi10_x, pvi12_x, pvi15_x, pvi16_x, pvi18_x);
% s = cat(1, pvi8_s, pvi9_s, pvi10_s, pvi12_s, pvi15_s, pvi16_s, pvi18_s);
% 
% %% to determine which rats are core/shell
% 
% core_rats = [1 2 3 5];
% shell_rats = [4 6 7];
% 
% %% saves file appropriately
% 
% save(strcat(masterpath2,'\Dropbox\MATLAB\Experiments\2013_PVI\data\allpvi'), 'x', 's',...
%     'core_rats', 'shell_rats');
