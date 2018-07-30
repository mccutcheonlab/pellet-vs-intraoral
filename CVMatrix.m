function CVMatrix(Rat, DAPeak, pHPeak, DACal)

ParentFolder = uigetdir('R:\DA_and_Reward\jem64\Publication Data\McCutcheon_ACSChem\Raw data and snipped trials', 'Please choose Chemometrics folder');
DAFolder = uigetdir(ParentFolder, 'Please choose DA folder');
pHFolder = uigetdir(ParentFolder, 'Please choose pH folder');
% DAPeak = 310; % DAPeak = input('Enter peak value for DA')
% pHPeak = 85; % pHPeak = input('Enter peak value for pH')
% DACal = 66.6; % DACal = input('Enter calibration value for DA')
pHCal = -10.439;

DACVs = getCols(DAFolder);
pHCVs = getCols(pHFolder);

AllCVs = [DACVs pHCVs];

DAConcs = mean(DACVs(DAPeak-4:DAPeak+5,:))*DACal;
DAConcs(2,:) = 0;

pHConcs(2,:) = mean(pHCVs(pHPeak-4:pHPeak+5,:))*pHCal;

AllConcs = [DAConcs pHConcs];

CVMatrixFile = [ParentFolder filesep Rat ' CVMatrix.txt'];
save(CVMatrixFile, 'AllCVs', '-ascii', '-tabs');

ConcMatrixFile = [ParentFolder filesep Rat ' ConcMatrix.txt'];
save(ConcMatrixFile, 'AllConcs', '-ascii', '-tabs');

% CVMatrix('PVI08',302,85,46.35) - Factors=3, Qa=263.276
% CVMatrix('PVI09',301,80,51.80) - Factors=3, Qa=472.082
% CVMatrix('PVI10',309,80,54.73) - Factors=3, Qa=475.669

% CVMatrix('PVI12',302,80,45.55) - Factors=2, Qa=491.02 *avg cal used (45.55)

% CVMatrix('PVI15',306,80,31.54) - Factors=2, Qa=1359.28
% CVMatrix('PVI16',317,80,39.24) - Factors=3, Qa=159.693
% CVMatrix('PVI18',300,80,49.66) - Factors=3, Qa=138.501
