function pvi_reptraces(ratnumber, datafolder)

load(strcat(datafolder, 'allpvi'))
pvi_cols;

Lrat = x(:,R_rat) == ratnumber;
Lclean = x(:,R_noise) ~= 1;

x_ax = [1:150];

%cued pellet trial
Lselect = x(:,R_trialtype) == 1 & Lrat &Lclean;
y = s(Lselect,51:200)';
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'r-','markerfacecolor','r'});
hold on; plot([1; 1], [5; 10]); axis off;

%cued infusion trial
Lselect = x(:,R_trialtype) == 2 & Lrat &Lclean;
y = s(Lselect,51:200)';
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'b-','markerfacecolor','b'});
hold on; plot([1; 1], [5; 10]); axis off;

%probe pellet trial
Lselect = x(:,R_trialtype) == 3 & Lrat &Lclean;
y = s(Lselect,51:200)';
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'b-','markerfacecolor','y'});
hold on; plot([1; 1], [5; 10]); axis off;

%probe infusion trial

Lselect = x(:,R_trialtype) == 4 & Lrat &Lclean;
y = s(Lselect,51:200)';
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem,{'g-','markerfacecolor','g'});
hold on; plot([1; 1], [5; 10]); axis off;

%dummy trial
Lselect = x(:,R_trialtype) == 5 & Lrat &Lclean;
y = s(Lselect,51:200)';
ymean = mean(y,2);
ysem = std(y')' / sqrt(size(y,2));

shadedErrorBar(x_ax,ymean,ysem, {'k-','markerfacecolor','k'});
hold on; plot([1; 1], [5; 10]); axis off;

hold off