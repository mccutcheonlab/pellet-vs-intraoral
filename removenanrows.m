function [output] = removenanrows(data)

data(any(isnan(data),2),:) = [];

output = data;