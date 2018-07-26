clear all
setpath
datafolder = '\PVI10\120927_TestDay1\02_Electrode_JM1\01_session\';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_2\!2012-09-27_13h54m.Subject PVI10';

rat = 10;
date = 120927;
region = 1;

% noise.pelletcue = [14 16];
% noise.infcue = [4];
% noise.probepellet = [4];
% noise.probeinf = [];
% noise.dummy = [2];


%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI10\120927_TestDay1\02_Electrode_JM1\01_session\';
Qa = 475.669;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_10';

voltdata_pvi