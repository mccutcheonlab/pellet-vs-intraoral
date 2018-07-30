function [output] = getCols(folder)

x=1; % column to put data in
dirListing = dir(folder);

for d = 1:length(dirListing)
    if ~dirListing(d).isdir
        fileName = fullfile(folder,dirListing(d).name); % use full path because the folder may not be the active path
                
        fid = fopen(fileName);
        concs(:,x) = textscan(fid, '%*f %*f %f');
        fclose(fid);
        x=x+1;
    end % if-clause
     
end % for-loop

% if exist concs
    output = cell2mat(concs);
% else
%     msgbox No appropriate files in those folders!
% stop
% end
