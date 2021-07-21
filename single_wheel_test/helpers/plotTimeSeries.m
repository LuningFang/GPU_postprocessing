% plot time series and return steady state value of dbp and trq
function [sinkage_avg, dbp_avg, trq_avg] = plotTimeSeries(filename, drawPlots)
global topLayerPositions
LW = 3;
FS = 28;

result = dlmread(filename, ' ');

% TODO 
%result = result(1:100,1:2:end);
result = result(:,1:2:end);

t = result(:,1);
pz = result(:,4);
px = result(:, 2);
initial_height_array=zeros(length(px),1);
for ii = 1:length(px)
    initial_height_array(ii) = find_initial_height(px(ii), topLayerPositions);
end

% TODO modify this 
wheel_radius = 0.13;
%wheel_radius = 0.305;
sinkage = initial_height_array - (pz - wheel_radius);
sinkage_avg = steadyState(sinkage);

if drawPlots == true
    subplot(3,1,1);
    makePlot(t,sinkage*1000,'time', 'sinkage (mm)', '', LW, FS);
    hold on
    grid on
end

dbp = result(:,14);

if drawPlots == true
    subplot(3,1,2)
    makePlot(t(1:end), dbp(1:end),'time', 'draw bar pull (N)', '', LW, FS);
    hold on
    grid on
end
dbp_avg = steadyState(dbp);

trq = result(:,30);

if drawPlots == true
    subplot(3,1,3)
    makePlot(t(1:end), trq(1:end),'time', 'torque (N-m)', '', LW, FS);
    hold on
    grid on
end

trq_avg = steadyState(trq);


end
