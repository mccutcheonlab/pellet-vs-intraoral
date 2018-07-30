function [unpacked_data] = unpacked(a)

data = dlmread(a, '\t', 8,0);

start = find(data == 0.3) + 1;
varstart = start + 26;
n = data(start);
size = max(data(start:start+25));
unpacked_data = nans(size,26);
for i = 1:26
    varend = varstart + n - 1;
    
    unpacked_data(1:n,i) = data(varstart:varend,1);
    varstart = varend + 1;
    n = data(start+i);
end






