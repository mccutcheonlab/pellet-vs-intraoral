clear all
setpath;
datafolder = strcat(masterfolder, 'Raw data and snipped trials\pvi09';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_2\!2012-09-26_11h23m.Subject PVI9';

rat = 9;
date = 120926;
region = 1;

% noise.pelletcue = [];
% noise.infcue = [4];
% noise.probepellet = [4 10];
% noise.probeinf = [];
% noise.dummy = [5 10];


%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI09\120926_TestDay1\01_Electrode_AA\01_session\';
Qa = 472.082;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = strcat(masterfolder, 'Extracted Matlab data\pvi_09');

voltdata_pvi