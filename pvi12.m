%for pvi12
clear all
setpath
datafolder = '\PVI12\121129_TestDay1\03_Electrode\01_Session\';

behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_3\!2012-11-29_13h47m.Subject PVI12';

rat = 12;
date = 121129;
region = 2;

% noise.pelletcue = [1];
% noise.infcue = [3];
% noise.probepellet = [];
% noise.probeinf = [];
% noise.dummy = [];

%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI12\121129_TestDay1\03_Electrode\01_Session\';
Qa = 491.02;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_12';

voltdata_pvi