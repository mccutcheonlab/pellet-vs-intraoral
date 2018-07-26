clear all
setpath;
datafolder = '\PVI08\120925_TestDay1\02_Electrode_JM1\01_session\';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_2\!2012-09-25_12h43m.Subject PVI8';

rat = 8;
date = 120925;
region = 1;

% noise.pelletcue = [11];
% noise.infcue = [];
% noise.probepellet = [1 2 14];
% noise.probeinf = [];
% noise.dummy = [];


%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI08\120925_TestDay1\02_Electrode_JM1\01_session\';
Qa = 225.835;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_08';

voltdata_pvi