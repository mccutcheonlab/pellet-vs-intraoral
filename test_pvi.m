% basic script to show number of noisy trials in different settings

loadfile = 'C:\Users\James Rig\Dropbox\MATLAB\Experiments\2013_PVI\data\allpvi';
loadfile = strcat(masterfolder, '\Extracted Matlab data\allpvi');

load(loadfile)

pvi_cols;

Lnoise = x(:,R_noise) == 1;

rats = unique(x(:,R_rat)); % determines rat numbers

for i = 1:length(rats)
    Lrat = x(:,R_rat) == rats(i);
    L = Lrat & Lnoise;
    for j = 1:5
        Ltrial = x(:,R_trialtype) == j;
        L = Lrat & Lnoise & Ltrial;
        strcat('PVI', num2str(rats(i)), ' - ', num2str(sum(L)))
    end
end



extractdata(masterfolder, ratname, ratnumber, date, region, behavfile, Qa)

datafolder = strcat(masterfolder, 'Raw data and snipped trials\', 'pvi18', '\');
Qa=138.501
noise.pelletcue = noiseQa(strcat(datafolder,'01_pelletcue\BATCH_PC'),Qa,[51:200]);