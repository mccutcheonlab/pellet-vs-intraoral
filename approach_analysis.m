function approach_analysis(loadfile)

masterfolder = 'R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\';
loadfile = 'C:\Users\James Rig\Dropbox\MATLAB\Experiments\2013_PVI\data\allpvi';
loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

load(loadfile)
pvi_cols;

s = adj_baseline(s,100,50,1);

Lnoise = x(:,R_noise) ~= 1;

Lreal = x(:,R_latency) > -0.0001; % excludes latencies that are set to negative numbers as these represent missed trials
Lapproach = x(:,R_approach) > 0;

rats = unique(x(:,R_rat)); % determines rat numbers

[DA_mean approach_mean latency_mean] = deal(nans(length(rats),1));
trialtypes = {'Cued pellet', 'Cued infusions'};

[DA_approach N_approach] = deal(nans(length(rats),2,2));

for i = 1:length(rats)
    for j = 1:length(trialtypes)
        Ltrial = x(:,R_trialtype) == j;
        Lrat = x(:,R_rat) == rats(i);
        L = Lrat & Lnoise & Ltrial;
        DApeaks = mean(s(L,101:130),2);
        
        % for plots of individual rats
%         figure()
%         ax1 = subplot(1,2,1);
%         scatter(x(L,R_approach),DApeaks);
%         ylim([-20 60]);
%         ylabel('DA peak (1s)');
%         xlabel('Approach (ms)');
%         title(strcat('PVI', num2str(rats(i))));
%         
%         ax2 = subplot(1,2,2);
%         scatter(x(L,R_latency),DApeaks);
%         ylim([-20 60]);
%         xlabel('Latency (s)');
        
        DA_mean(i) = mean(DApeaks);
        approach_mean(i) = mean(x(L,R_approach));
        latency_mean(i) = mean(x(L,R_latency));
        
        L = Lrat & Lnoise & Ltrial & ~Lapproach; %trials with no approach
        DA_approach(i,1,j) = mean(mean(s(L,101:130),2));
        N_approach(i,1,j) = sum(L);
        L = Lrat & Lnoise & Ltrial & Lapproach; %trials with approach
        DA_approach(i,2,j) = mean(mean(s(L,101:130),2));
        N_approach(i,2,j) = sum(L);

    end
end

% 
% figure()
% ax1 = subplot(1,2,1);
% scatter(approach_mean,DA_mean);
% ylabel('DA peak (1s)');
% xlabel('Approach (ms)');
% title('Mean of each rat');
% 
% ax2 = subplot(1,2,2);
% scatter(latency_mean,DA_mean);
% ylim([-20 60]);
% xlabel('Latency (s)');

probability_approach = squeeze(N_approach(:,2,:) ./ sum(N_approach,2));
prob_approach_fig(probability_approach);

approach_and_volt_fig(DA_approach);