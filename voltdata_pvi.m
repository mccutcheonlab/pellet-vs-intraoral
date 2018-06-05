%% uses variables from each rat to compile data into x and s matrices
% this function is called by each individual rat file to make rat.mat
% matrices

%% extracts CONCs
cuepellet = trials(strcat(masterpath,datafolder,'CUT_pelletcue'));
cueinf = trials(strcat(masterpath,datafolder,'CUT_infcue'));
probepellet = trials(strcat(masterpath,datafolder,'CUT_probepellet'));
probeinf = trials(strcat(masterpath,datafolder,'CUT_probeinf'));
dummy = trials(strcat(masterpath,datafolder,'CUT_dummy'));

behav_data = unpacked(behavfile);

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

%checks that n of trial types from CONCs and behav_data match
% if isequal(length_mat(1,:),length_mat(2,:)) == 0;
%     removelast;
% end    

make_noise;

pvi_cols;

x = nans(nrows,8); %sets size of x, change if adding more columns

x(:,R_rat) = rat;
x(:,R_date) = date;
x(:,R_region) = region;
x(:,R_trialN) = extract_sort(:,1);
x(:,R_trialtype) = extract_sort(:,2);
x(:,R_latency) = extract_sort(:,3);
x(:,R_approach) = extract_sort(:,4);
x(noise_all,R_noise) = 1;

% x(:,10:11) = pvi_approach(behavfile);

%% to save variables in structured array
struct.(strcat('pvi',num2str(rat), '_x')) = x;
struct.(strcat('pvi',num2str(rat), '_s')) = s;
struct.(strcat('pvi',num2str(rat), '_behav')) = behav_data;

save(strcat(masterpath2,savefile), '-struct', 'struct');


