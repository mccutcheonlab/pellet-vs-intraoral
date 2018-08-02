function extractdata(masterfolder, ratname, ratnumber, date, region, behavfile, Qa)

datafolder = strcat(masterfolder, 'Raw data and snipped trials\', ratname, '\');

noise.pelletcue = noiseQa(strcat(datafolder,'01_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(datafolder,'02_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(datafolder,'03_probepellet\BATCH_PC'),Qa,[51:200]);
noise.probeinf = noiseQa(strcat(datafolder,'04_probeinf\BATCH_PC'),Qa,[51:200]);
noise.dummy = noiseQa(strcat(datafolder,'05_dummy\BATCH_PC'),Qa,[51:200]);

savefile = strcat(masterfolder, 'Extracted Matlab data\', ratname);

%% uses variables from each rat to compile data into x and s matrices
% this function is called by each individual rat file to make rat.mat
% matrices

%% extracts CONCs
[cuepellet cuep_fileIDs] = trials(strcat(datafolder,'01_pelletcue\BATCH_PC'));
[cueinf cueinf_fileIDs] = trials(strcat(datafolder,'02_infcue\BATCH_PC'));
[probepellet pp_fileIDs] = trials(strcat(datafolder,'03_probepellet\BATCH_PC'));
[probeinf pinf_fileIDs] = trials(strcat(datafolder,'04_probeinf\BATCH_PC'));
[dummy dummy_fileIDs] = trials(strcat(datafolder,'05_dummy\BATCH_PC'));

%% extracts behavior
behav_data = unpacked(strcat(datafolder, behavfile));

%% assembles matrix with total number of each of trial type taken from CONCs
length_mat(1,1) = size(cuepellet,2);
length_mat(1,2) = size(cueinf,2);
length_mat(1,3) = size(probepellet,2);
length_mat(1,4) = size(probeinf,2);
length_mat(1,5) = size(dummy,2);

%% compiles into single s matrix
s = cat(2,cuepellet,cueinf,probepellet,probeinf,dummy);
s = s';

nrows = size(s,1);

%%  code to make x matrix
% ntrials = sum(behav_data(:,18) > 0); %works out number of trials from behav_data
extract = [1:nrows; behav_data(2:nrows+1,18)'; behav_data(2:nrows+1,12)'; behav_data(2:nrows+1,3)'];
extract = extract';
extract_sort = sortrows(extract,2);

% works out number of each trial type taken from behav_data
for i = 1:5;
    length_mat(2,i) = sum(extract(:,2) == i);
end

make_noise;
pvi_cols;

x = nans(nrows,9); %sets size of x, change if adding more columns

x(:,R_rat) = ratnumber;
x(:,R_date) = date;
x(:,R_region) = region;
x(:,R_trialN) = extract_sort(:,1);
x(:,R_trialtype) = extract_sort(:,2);
x(:,R_latency) = extract_sort(:,3);
x(:,R_approach) = extract_sort(:,4);
x(noise_all,R_noise) = 1;
x(:,R_fileID) = cat(2, cuep_fileIDs, cueinf_fileIDs, pp_fileIDs, pinf_fileIDs, dummy_fileIDs)';

for i = 1:5;
    Ltrial = x(:,R_trialtype) == i;
    fileIDs = x(Ltrial,R_fileID);
    if fileIDs(end) < fileIDs(1)
        msgbox(strcat('Check Med file and voltammetry data to ensure trial types match up'))
    end
end

%% to save variables in structured array
struct.(strcat(ratname, '_x')) = x;
struct.(strcat(ratname, '_s')) = s;
struct.(strcat(ratname, '_behav')) = behav_data;

save(strcat(savefile), '-struct', 'struct');
