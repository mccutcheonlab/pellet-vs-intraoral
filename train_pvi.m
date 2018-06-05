%% for unpacking training data and finding averages

clear all
setpath

%% sets columns of training matrix
t_rat = 1;
t_day = 2;
t_ttype = 3;
t_lat = 4;
t_app = 5;
t_zero = 6;

%% individual rats
%for pvi02
rat = 2;
behavfiles = {'!2012-08-13_10h17m.Subject PVI2', '!2012-08-14_11h43m.Subject PVI2', '!2012-08-15_10h42m.Subject PVI2', '!2012-08-16_09h12m.Subject PVI2', '!2012-08-17_10h28m.Subject PVI2', '!2012-08-28_10h47m.Subject PVI2'};
train_pvi02 = train_beh_pvi(rat, behavfiles);

%for pvi08
rat = 8;
behavfiles = {'!2012-09-12_10h48m.Subject PVI8', '!2012-09-13_10h33m.Subject PVI8', '!2012-09-14_10h44m.Subject PVI8', '!2012-09-15_14h17m.Subject PVI8', '!2012-09-16_13h30m.Subject PVI8', '!2012-09-24_11h01m.Subject PVI8'};
train_pvi08 = train_beh_pvi(rat, behavfiles);

%for pvi09
rat = 9;
behavfiles = {'!2012-09-12_11h54m.Subject PVI9', '!2012-09-13_09h30m.Subject PVI9', '!2012-09-14_11h50m.Subject PVI9', '!2012-09-15_13h13m.Subject PVI9', '!2012-09-16_14h32m.Subject PVI9', '!2012-09-24_12h05m.Subject PVI9', '!2012-09-25_09h26m.Subject PVI9'};
train_pvi09 = train_beh_pvi(rat, behavfiles);

%for pvi10
rat = 10;
behavfiles = {'!2012-09-12_11h54m.Subject PVI10', '!2012-09-13_09h30m.Subject PVI10', '!2012-09-14_11h50m.Subject PVI10', '!2012-09-15_13h13m.Subject PVI10', '!2012-09-16_14h32m.Subject PVI10', '!2012-09-24_12h05m.Subject PVI10', '!2012-09-25_10h54m.Subject PVI10'};
train_pvi10 = train_beh_pvi(rat, behavfiles);

%for pvi12
rat = 12;
behavfiles = {'!2012-11-12_11h28m.Subject PVI12', '!2012-11-13_11h34m.Subject PVI12', '!2012-11-14_10h36m.Subject PVI12', '!2012-11-15_10h21m.Subject PVI12', '!2012-11-16_10h39m.Subject PVI12', '!2012-11-27_11h32m.Subject PVI12', '!2012-11-28_08h58m.Subject PVI12'};
train_pvi12 = train_beh_pvi(rat, behavfiles);

%for pvi15
rat = 15;
behavfiles = {'!2012-12-03_10h21m.Subject PVI15', '!2012-12-04_10h20m.Subject PVI15', '!2012-12-05_09h03m.Subject PVI15', '!2012-12-06_10h15m.Subject PVI15', '!2012-12-07_08h58m.Subject PVI15', '!2012-12-16_12h32m.Subject PVI15', '!2012-12-17_10h30m.Subject PVI15'};
train_pvi15 = train_beh_pvi(rat, behavfiles);

%for pvi16
rat = 16;
behavfiles = {'!2012-12-03_10h21m.Subject PVI16', '!2012-12-04_10h20m.Subject PVI16', '!2012-12-05_09h03m.Subject PVI16', '!2012-12-06_10h15m.Subject PVI16', '!2012-12-07_08h58m.Subject PVI16', '!2012-12-16_12h32m.Subject PVI16', '!2012-12-17_11h28m.Subject PVI16'};
train_pvi16 = train_beh_pvi(rat, behavfiles);

%for pvi18
rat = 18;
behavfiles = {'!2012-12-03_11h22m.Subject PVI18', '!2012-12-04_09h25m.Subject PVI18', '!2012-12-05_10h05m.Subject PVI18', '!2012-12-06_09h14m.Subject PVI18', '!2012-12-07_10h31m.Subject PVI18', '!2012-12-17_11h28m.Subject PVI18', '!2012-12-18_08h55m.Subject PVI18'};
train_pvi18 = train_beh_pvi(rat, behavfiles);

%% to combine all data
train_pvi_all = cat(1, train_pvi08, train_pvi09, train_pvi10, train_pvi12, train_pvi15, train_pvi16, train_pvi18);

%% Logical indexes for pellet/inf trials
Lpellet = train_pvi_all(:,t_ttype) == 1;
Linf = train_pvi_all(:,t_ttype) == 2;

rats = unique(train_pvi_all(:,t_rat));
days = unique(train_pvi_all(:,t_day));
train_avgs.lat = nans(length(rats),length(days),2);
train_avgs.app = nans(length(rats),length(days),2);
train_avgs.zeros = nans(length(rats),length(days),2);

%% extracts averages for each parameter, for each rat, for each day to create
%  train_avgs structured array
for i = 1:length(rats);
    Lrat = train_pvi_all(:,t_rat) == rats(i); %sets appropriate rat
    days = unique(train_pvi_all(Lrat,t_day)); %recalculates days depending on rat to be analyzed, i.e. some might not have data for all days
    for j = 1:length(days);
        
        Lday = train_pvi_all(:,t_day) == days(j); %sets appropriate day
        
        Lselect = Lrat & Lday & Lpellet & train_pvi_all(:,t_lat) >= 0;
        train_avgs.lat(i,j,1) = mean(train_pvi_all(Lselect,t_lat)); % latencies - pellet
                
        Lzero = Lrat & Lday & Lpellet & train_pvi_all(:,t_lat) == 0;
        Ltotal = Lrat & Lday & Lpellet;
        train_avgs.zeros(i,j,1) = sum(Lzero)/sum(Ltotal); %zeros - pellet
                
        Lmiss = Lrat & Lday & Lpellet & train_pvi_all(:,t_lat) < 0;
        train_avgs.miss(i,j,1) = sum(Lmiss)/sum(Ltotal); %misses - pellet
                
        Lselect = Lrat & Lday & Lpellet & train_pvi_all(:,t_app) >= 0;
        train_avgs.app(i,j,1) = mean(train_pvi_all(Lselect,t_app)); %approach - pellet
                
        Lselect = Lrat & Lday & Linf & train_pvi_all(:,t_lat) >= 0;
        train_avgs.lat(i,j,2) = mean(train_pvi_all(Lselect,t_lat)); %latencies - inf
                
        Lzero = Lrat & Lday & Linf & train_pvi_all(:,t_lat) == 0;
        Ltotal = Lrat & Lday & Linf;
        train_avgs.zeros(i,j,2) = sum(Lzero)/sum(Ltotal); %zeros - inf
                
        Lmiss = Lrat & Lday & Linf & train_pvi_all(:,t_lat) < 0;
        train_avgs.miss(i,j,2) = sum(Lmiss)/sum(Ltotal); %misses - inf
        
        Lselect = Lrat & Lday & Linf & train_pvi_all(:,t_app) >= 0;
        train_avgs.app(i,j,2) = mean(train_pvi_all(Lselect,t_app)); %approach - inf
    end
end

%% finds means of each
train_avgs.latx = squeeze(nanmean(train_avgs.lat))';
train_avgs.appx = squeeze(nanmean(train_avgs.app))';
train_avgs.zerox = squeeze(nanmean(train_avgs.zeros))';
train_avgs.missx = squeeze(nanmean(train_avgs.miss))';

%% makes mean, SD, SEM table

xl_lat = cat(1,train_avgs.lat(:,:,1),train_avgs.lat(:,:,2));
xl_app = cat(1,train_avgs.app(:,:,1),train_avgs.app(:,:,2));
xl_zeros = cat(1,train_avgs.zeros(:,:,1),train_avgs.zeros(:,:,2));
xl_miss = cat(1,train_avgs.miss(:,:,1),train_avgs.miss(:,:,2));



%% saves file
savefile = '\Dropbox\MATLAB\Experiments\PVI\data\train_data';
save(strcat(masterpath2,savefile),'train_avgs', 'train_pvi_all');

%% for further analysis
clear all
load train_data

%% for making training figures

train_pvi_fig(train_avgs.lat(:,:,1),train_avgs.latx(1,:),...
    train_avgs.lat(:,:,2),train_avgs.latx(2,:),'latency (s)')

train_pvi_fig(train_avgs.zeros(:,:,1),train_avgs.zerox(1,:),...
    train_avgs.zeros(:,:,2),train_avgs.zerox(2,:),'proportion of zeros')

train_pvi_fig(train_avgs.app(:,:,1),train_avgs.appx(1,:),...
    train_avgs.app(:,:,2),train_avgs.appx(2,:),'head entries during cue (ms)')

train_pvi_fig(train_avgs.miss(:,:,1),train_avgs.missx(1,:),...
    train_avgs.miss(:,:,2),train_avgs.missx(2,:),'proportion of misses')


%% statistics

% tests all animals days 1-6
pellet = train_avgs.zeros(:,1:6,1);
inf = train_avgs.zeros(:,1:6,2);
anova_rm({pellet inf})

%tests rats 3-8 days 1-7
pellet = train_avgs.zeros(3:end,:,1);
inf = train_avgs.zeros(3:end,:,2);
anova_rm({pellet inf})

pellet = train_avgs.app(3:end,2:6,1);
inf = train_avgs.app(3:end,2:6,2);
anova_rm({pellet inf})

