clear all

datafolder = '\PVI18\121219_TestDay1\01_Electrode_AA\01_session\';
behavfile = '!2012-12-19_12h48m.Subject PVI18';

rat = 18;
date = 121219;
region = 2;

noise.pelletcue = [9 10 14 23];
noise.infcue = [2 8];
noise.probepellet = [4];
noise.probeinf = [9];
noise.dummy = [1 4 5 7 11];

savefile = '\Dropbox\MATLAB\Experiments\PVI\pvi_18';

voltdata_pvi