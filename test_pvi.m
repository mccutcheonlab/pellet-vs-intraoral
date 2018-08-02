% basic script to show number of noisy trials in different settings
masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\';
loadfile = 'C:\Users\James Rig\Dropbox\MATLAB\Experiments\2013_PVI\data\allpvi';
loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

load(loadfile)

pvi_cols;

Ltrial = x(:,R_trialtype) == 1;




% Lnoise = x(:,R_noise) ~= 1;
% Lrat = x(:,R_rat) == 10;
% 
% 
% L = Lnoise & Lrat & Ltrial;
% sum(L)
% 
% pvi10_probeinfs = s(L,:);
% 
% pvi10_probeinfs_adj = adj_baseline(pvi10_probeinfs, 100, 50, 1);
% 
% 
% 
% extractdata(masterfolder, 'pvi10', 99, 999999, 9, '!2012-09-27_13h54m.Subject PVI10', 475.669)





% 
% Lnoise = x(:,R_noise) == 1;
% 
% rats = unique(x(:,R_rat)); % determines rat numbers
% 
% for i = 1:length(rats)
%     Lrat = x(:,R_rat) == rats(i);
%     L = Lrat & Lnoise;
%     for j = 1:5
%         Ltrial = x(:,R_trialtype) == j;
%         L = Lrat & Lnoise & Ltrial;
%         strcat('PVI', num2str(rats(i)), ' - ', num2str(sum(L)))
%     end
% end
% 
% extractdata(masterfolder, ratname, ratnumber, date, region, behavfile, Qa)
% 
% datafolder = strcat(masterfolder, 'Raw data and snipped trials\', 'pvi18', '\');
% Qa=138.501
% noise.pelletcue = noiseQa(strcat(datafolder,'01_pelletcue\BATCH_PC'),Qa,[51:200]);
