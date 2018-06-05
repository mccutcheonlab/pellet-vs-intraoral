%pvi_shaded

clear all
load allpvi
pvi_cols;

close all

[all_avg all_alldata] = voltanalysis_pvi(3,'rat','all, rat-by-rat');

%for cued trials
x_ax = [1:150];
y = all_alldata(51:200,:,1);
ymean = mean(y,2);
ysem = std(y')' / sqrt(7);

shadedErrorBar(x_ax,ymean,ysem,{'r-','markerfacecolor','r'})

hold on

y = all_alldata(51:200,:,2);
ymean = mean(y,2);
ysem = std(y')' / sqrt(7);

shadedErrorBar(x_ax,ymean,ysem,{'g-','markerfacecolor','g'})

%for uncued trials
close all

y = all_alldata(51:200,:,5); %dummy trial (at back)
ymean = mean(y,2);
ysem = std(y')' / sqrt(7);

shadedErrorBar(x_ax,ymean,ysem)

hold on

y = all_alldata(51:200,:,3);
ymean = mean(y,2);
ysem = std(y')' / sqrt(7);

shadedErrorBar(x_ax,ymean,ysem,{'y-','markerfacecolor','y'})

y = all_alldata(51:200,:,4);
ymean = mean(y,2);
ysem = std(y')' / sqrt(7);

shadedErrorBar(x_ax,ymean,ysem,{'g-','markerfacecolor','g'})

hold on


