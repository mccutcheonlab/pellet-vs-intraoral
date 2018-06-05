clear all
setpath
datafolder = '\PVI18\121219_TestDay1\01_Electrode_AA\01_session\';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_4\!2012-12-19_12h48m.Subject PVI18';

rat = 18;
date = 121219;
region = 2;

% noise.pelletcue = [9 10 14 23];
% noise.infcue = [2 8];
% noise.probepellet = [4];
% noise.probeinf = [9];
% noise.dummy = [1 4 5 7 11];

%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI18\121219_TestDay1\01_Electrode_AA\01_session\';
Qa = 138.501;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_18';

voltdata_pvi