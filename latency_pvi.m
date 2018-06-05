clear all; load allpvi; pvi_cols;

% finds raw latencies for probe pellet and cued pellet trials
L = x(:,R_trialtype) == 3;
latProbePellet = mean(x(L,R_latency)); %3.7895s

L = x(:,R_trialtype) == 1;
latCuedPellet = mean(x(L,R_latency)); %0.7390

% extracts latencies into array, also removes -0.01 (no pellet collections)
L = x(:,R_trialtype) == 3 & x(:,R_latency) ~= -0.01; 
latsPP = x(L,R_latency);
mean(latsPP) 
latsPP_sorted = sort(latsPP); %examination shows that 3s window accounts for approximately 2/3 or 70% of trials

% for working out on a rat-by-rat basis
rats = unique(x(:,R_rat));

for i = 1:length(rats)
    L = x(:,R_trialtype) == 3 & x(:,R_rat) == rats(i);
    latsPP_by_rat(i) = mean(x(L,R_latency));
end

%to consider in future: aligning to latency or only including trials with
%short latency collections...


%sorting latencies for cued pellet trials
L = x(:,R_trialtype) == 1 & x(:,R_latency) ~= -0.01; 
latsCP = x(L,R_latency);
mean(latsCP) 
latsCP_sorted = sort(latsCP); %examination shows that 1s window accounts for 86% trials