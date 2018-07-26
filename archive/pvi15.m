clear all
setpath

datafolder = '\PVI15\121218_TestDay1\01_Electrode_green\01_session\';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_4\!2012-12-18_11h00m.Subject PVI15';

rat = 15;
date = 121218;
region = 1;

% noise.pelletcue = [];
% noise.infcue = [];
% noise.probepellet = [3 11];
% noise.probeinf = [11];
% noise.dummy = [];

%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI15\121218_TestDay1\01_Electrode_green\01_session\';
Qa = 1359.28;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);

savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_15';

voltdata_pvi;