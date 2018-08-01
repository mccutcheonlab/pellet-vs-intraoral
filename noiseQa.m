function [output] = noiseQa(folder,Qa,range)

if exist('folder') == 0
    folder = uigetdir('F:\Jaime_Expts');
end

if exist('Qa') == 0
    Qa = input('Enter Qa value');
end

if exist('range') == 0
    range = [1:200];
end

x=1; z=[]; y=[]; b=[];

dirListing = dir(folder);

for d = 1:length(dirListing)
    if strcmp(regexp(dirListing(d).name, 'Q', 'match'), 'Q');
        y = [y d]; % get indices of Q files by adding current file to existing list of y
        a = regexp(dirListing(d).name, '[0-9]+', 'match');
        b = [b a(1)]; %adds 2nd digit to list of existing list of b
        
    end
end

f = dirListing(y); % make list of conc files
b=str2double(b);
[s,s]=sort(b); % sort by trial
f=f(s); % reorder conc files by trial (or by whatever is in b, if b is identical then will keep in directory order)


output = cell(0); outputInd = 1; fileInd = 1;

for d = 1:length(f)
    if ~f(d).isdir
        
        fileName = fullfile(folder,f(d).name); % use full path because the folder may not be the active path
        
        fid = fopen(fileName);
        data = cell2mat(textscan(fid, '%f'));
        fclose(fid);
        
        noisePoints = find(data(range) > Qa);
        if numel(noisePoints) > 0
            output(outputInd,1) = {fileInd};
            %uncomment to get file name and points where Qa crosses
            %threshold
%             output(outputInd,2) = {f(d).name}; 
%             output(outputInd,3) = {noisePoints};
            outputInd = outputInd + 1;
        end
        fileInd = fileInd+1;   
    end % if-clause
end

