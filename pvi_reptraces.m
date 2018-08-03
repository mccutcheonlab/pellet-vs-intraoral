function pvi_reptraces(loadfile, ratnumber, trialtypes)

load(loadfile)
pvi_cols;
pvi_colors;

Lrat = x(:,R_rat) == ratnumber;
Lclean = x(:,R_noise) ~= 1;

x_ax = [1:150];

figure()
hold on;

%cued pellet trial
if ismember(1,trialtypes) == 1
    Lselect = x(:,R_trialtype) == 1 & Lrat &Lclean;
    y = s(Lselect,51:200)';
    ymean = mean(y,2);
    ysem = std(y')' / sqrt(size(y,2));
    shadedErrorBar(x_ax,ymean,ysem,{'-','Color', red, 'markerfacecolor',red});
end

%cued infusion trial
if ismember(2,trialtypes) == 1
    Lselect = x(:,R_trialtype) == 2 & Lrat &Lclean;
    y = s(Lselect,51:200)';
    ymean = mean(y,2);
    ysem = std(y')' / sqrt(size(y,2));
    
    shadedErrorBar(x_ax,ymean,ysem,{'-','Color', blue,'markerfacecolor',blue});
    
end

%probe pellet trial
if ismember(3,trialtypes) == 1
    Lselect = x(:,R_trialtype) == 3 & Lrat &Lclean;
    y = s(Lselect,51:200)';
    ymean = mean(y,2);
    ysem = std(y')' / sqrt(size(y,2));
    shadedErrorBar(x_ax,ymean,ysem,{'-','Color', yellow, 'markerfacecolor',yellow});
end

%probe infusion trial
if ismember(4,trialtypes) == 1
    Lselect = x(:,R_trialtype) == 4 & Lrat &Lclean;
    y = s(Lselect,51:200)';
    ymean = mean(y,2);
    ysem = std(y')' / sqrt(size(y,2));
    shadedErrorBar(x_ax,ymean,ysem,{'-','Color', green,'markerfacecolor',green});
end

%dummy trial
if ismember(5,trialtypes) == 1
    Lselect = x(:,R_trialtype) == 5 & Lrat &Lclean;
    y = s(Lselect,51:200)';
    ymean = mean(y,2);
    ysem = std(y')' / sqrt(size(y,2));
    shadedErrorBar(x_ax,ymean,ysem, {'-','Color', grey,'markerfacecolor',grey});
end

plot([1; 1], [5; 10]); axis off;
hold off