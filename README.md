# pellet-vs-intraoral

This repository contains analysis scripts for a study using fast-scan cyclic voltammetry to inevstigate dopamine's role in signaling cues and rewards. The experiment is published in xxx.

The scripts were all written in Matlab 2013a and the data files required to run them - including all raw data files - have been uploaded to figshare and can be found at doi:10.6084/m9.figshare.6387392. The .zip archive, Extracted Matlab data, is sufficient to run most of the Matlab analysis and is far smaller than the other .zip archive, Raw data and snipped files.

The .mat matrices in Extracted Matlab data consist of baseline-subtracted dopamine concentration data sampled at 10 Hz in 20 second trials aligned to either cue onset or, when cues were not present, to reward delivery. Voltammetry data are contained in the 's' matrix/variable and metadata, relating to each file, are contained in the 'x' matrix. The allpvi.mat file is a combination of data from all rats and can be used for all subsequent analysis.

The Word file in this folder, 'Notes for Matlab analysis code.docx', has more information on the steps used to extract data and some description of each function.

Any problems or questions about the data or code can be addressed to Dr. James McCutcheon at jem64@le.ac.uk or mccutcheon.james@gmail.com.
