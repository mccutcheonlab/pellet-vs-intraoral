function pvi_rocfigs(a,p,trialtype)

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YTick',[0.3 0.4 0.5 0.6 0.7]); %add for ticks 'XTick',1
%xlim(axes1,[0.5 2.5]);
ylim(axes1,[0.3 0.7]);
hold(axes1,'all');

plot(a)

L = p < (0.05/length(p));
sig = [find(p<(0.05/length(p))); a(L)]';

scatter(sig(:,1),sig(:,2));

title(trialtype);