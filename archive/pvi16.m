clear all
setpath;
datafolder = '\PVI16\121218_TestDay1\02_Electrode_CC\01_session\';
behavfile = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\Med_Data\Cohort_4\!2012-12-18_15h02m.Subject PVI16';

rat = 16;
date = 121218;
region = 2;

% noise.pelletcue = [3 4 19];
% noise.infcue = [6 24];
% noise.probepellet = [1 3];
% noise.probeinf = [14];
% noise.dummy = [];

%% new noise analysis

filepath = 'F:\Jaime_Expts\Moved_to_server\1209_PelletVsIO\PVI16\121218_TestDay1\02_Electrode_CC\01_session\';
Qa = 213.765;

noise.pelletcue = noiseQa(strcat(filepath,'CUT_pelletcue\BATCH_PC'),Qa,[51:200]);
noise.infcue = noiseQa(strcat(filepath,'CUT_infcue\BATCH_PC'),Qa,[51:200]);
noise.probepellet = noiseQa(strcat(filepath,'CUT_probepellet\BATCH_PC'),Qa,[21:170]);
noise.probeinf = noiseQa(strcat(filepath,'CUT_probeinf\BATCH_PC'),Qa,[21:170]);
noise.dummy = noiseQa(strcat(filepath,'CUT_dummy\BATCH_PC'),Qa,[21:170]);
savefile = '\Dropbox\MATLAB\Experiments\2013_PVI\pvi_16';

voltdata_pvi;



%pvi16 -day 2
% datafolder = '\PVI16\121221_TestDay2\01_Electrode_JM1\01_session\';
% behavfile = '';
% 
% rat = 16;
% date = 121221;
% region = 2;
% 
% noise.pelletcue = [];
% noise.infcue = [5];
% noise.probepellet = [12];
% noise.probeinf = [];
% noise.dummy = [1];
% 
% savefile = '\Dropbox\MATLAB\Experiments\PVI\pvi_16';