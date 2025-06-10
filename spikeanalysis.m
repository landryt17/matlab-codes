data = Fluorescence1;
%file name
s = size(data);
time = table2array(data(1:s(1),1));
control = table2array(data(1:s(1),3));
%control column
gcamp = table2array(data(1:s(1),4));
%gcamp column
ratio = gcamp./control;
%normalize to control
filter = movmin(ratio,100);
deltaFoverF = (((ratio./filter))-1)*100;
% normalize to moving minimum
standarddev = 3.*std(deltaFoverF);
threshold = standarddev + median(deltaFoverF);
plot (deltaFoverF);

event = deltaFoverF > threshold;
event_count=sum(event);
%total spikes
event_amp = deltaFoverF(event);
mean_amp = mean(event_amp);
%average amplitude of spikes