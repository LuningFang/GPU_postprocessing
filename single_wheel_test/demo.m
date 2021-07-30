clear all
clc
close all
global topLayerPositions particle_diameter
addpath('../plot_tools/')
addpath('helpers');
close all

particle_diameter = 0.01;
% png_name = strcat('fig/cyl_sweep_mus_slip', '.',  'png');
% fig_name = strcat('fig/cyl_sweep_mus_slip', '.',  'fig');

drawTimePlotsFlag = true;
home_dir = 'data/hex/';
settled_pos_filename = strcat(home_dir, 'checkpoint_settled.dat');
rig_filename = strcat(home_dir, 'results.dat');


entries = dlmread(settled_pos_filename, ' ');
x_pos = entries(:,2);
y_pos = entries(:,3);
z_pos = entries(:,4);

initial_height = max(z_pos);


LW = 3;
FS = 28;
drawPlots = true;
rig_result = dlmread(rig_filename, ' ');
% dlm read gives too many zeros...
rig_result = rig_result(:,1:2:end);
t = rig_result(:,1);
pz = rig_result(:,4);
px = rig_result(:, 2);

initial_height_array = ones(length(px),1) * initial_height;

wheel_radius = 0.13;
sinkage = initial_height_array - (pz - wheel_radius);
sinkage_avg = steadyState(sinkage);

if drawPlots == true
    subplot(3,1,1);
    makePlot(t,sinkage*1000,'time', 'sinkage (mm)', '', LW, FS);
    hold on
    grid on
end

dbp = rig_result(:,14);

if drawPlots == true
    subplot(3,1,2)
    makePlot(t(1:end), dbp(1:end),'time', 'draw bar pull (N)', '', LW, FS);
    hold on
    grid on
end
dbp_avg = steadyState(dbp);

trq = rig_result(:,30);

if drawPlots == true
    subplot(3,1,3)
    makePlot(t(1:end), trq(1:end),'time', 'torque (N-m)', '', LW, FS);
    hold on
    grid on
end

trq_avg = steadyState(trq);