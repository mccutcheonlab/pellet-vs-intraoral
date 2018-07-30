function [result] = adj_baseline_update(concs,tzero,bl,transpose);
%need to add tzero (100), bl (50) both in scans
%all based on average of 10 scans

if transpose == 1
    concs = concs'
end

x = tzero - bl;
for i = 1:bl-10;
    BLs(i,:) = mean(concs(x + i:x + 9 + i,:));
end

BL = min(BLs,[],1);

for i = 1:size(concs,2);
    result(:,i) = concs(:,i) - BL(i);
end

if transpose == 1
    result = result'
end
