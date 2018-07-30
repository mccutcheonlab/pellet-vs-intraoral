%this function extracts CONC files from a folder. It searches for files
%with 'CONC' in the name and sorts them by the second digit in their name.
%If the second digit is identical (e.g. because they all havw the same
%prefix) then it will sort them according to their default folder sort
%(alphabetical?). Basically, care should be taken that the files come out
%in the right order. Looking at the 

function [trials] = trials(folder) %LINE 24 CHANGED TO COPE WITH FILES WITH ONLY ONE DIGIT!!!
x=1; %column of matrix to place data in
z=[];
y=[];
b=[];

if exist('folder') == 0
    folder = uigetdir('F:\Jaime_Expts');
end

dirListing = dir(folder);

for d = 1:length(dirListing)
    if strcmp(regexp(dirListing(d).name, 'CONC', 'match'), 'CONC');
        y = [y d]; % get indices of CONC files by adding current file to existing list of y
        a = regexp(dirListing(d).name, '[0-9]+', 'match');
        b = [b a(1)]; %adds 2nd digit to list of existing list of b
        
    end
end

f = dirListing(y); % make list of conc files
b=str2double(b);
[s,s]=sort(b); % sort by trial
f=f(s); % reorder conc files by trial (or by whatever is in b, if b is identical then will keep in directory order)

for d = 1:length(f)
    if ~f(d).isdir
        fileName = fullfile(folder,f(d).name); % use full path because the folder may not be the active path
                
        fid = fopen(fileName);
        concs(:,x) = textscan(fid, '%f %*f');
        fclose(fid);
        
        [p,n,e] = fileparts(f(d).name);
        if regexp(e, '.bad') == 1;
            z=[z x];
        end
        x=x+1;
    end % if-clause
      
    
end % for-loop

trials = cell2mat(concs); %converts cell array into matrix

trials(:,z)=nan;    %put 'bad' trials in z


%rewardAvg = mean(trials(101:110,:)); %finds average of reward epoch in each trial

% avg=nanmean(JB5,2)
% JB5All = [JB5suc1 JB5sacc JB5suc2] %joins matrices
% AllRats = cat(3,JB5All,JB6All) %joins matrices on third dimension
% AvgAllRats = nanmean(AllRats,3) %means along third dimension



