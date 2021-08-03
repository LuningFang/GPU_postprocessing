clear all
clc
close all

% hcp distribution with separation factor 1.005
% mur default value
% vary mus
% ke = 1e6
% slip ratio 0.5

global particle_diameter
addpath('../plot_tools/');
addpath('helpers');

particle_diameter = 0.01;
wheel_radius = 0.13;
drawPlots = true;
home_dir = 'data/sep_1_thinner/';

mus_array = [ 0.4 0.5, 0.6, 0.7, 0.8 0.9 0.95];
numTests = length(mus_array);

% data for plotting
sinkage_avg_array = zeros(numTests, 1);
trq_avg_array = zeros(numTests, 1);
dbp_avg_array = zeros(numTests, 1);

sinkage_std_array = zeros(numTests, 1);
trq_std_array = zeros(numTests, 1);
dbp_std_array = zeros(numTests, 1);
LW = 3;
MS = 10;
FS =30;


for jj = 1:numTests
    mus = mus_array(jj);
    rig_filename = strcat(home_dir, sprintf('mus=%.1f.dat', mus));
    settled_pos_filename = strcat(home_dir, sprintf('mus=%.1f_settled.dat', mus));
    settled_pos_filename
    
    entries = dlmread(settled_pos_filename, ' ');
    x_pos = entries(:,2);
    y_pos = entries(:,3);
    z_pos = entries(:,4);
    initial_height = max(z_pos);
    
    rig_result = dlmread(rig_filename, ' ');
    % dlm read gives too many zeros...
    rig_result = rig_result(:,1:2:end);
    t = rig_result(:,1);
    pz = rig_result(:,4);
    px = rig_result(:, 2);
    
    initial_height_array = ones(length(px),1) * initial_height;
    
    wheel_radius = 0.13;
    sinkage = initial_height_array - (pz - wheel_radius);
    sinkage_ss = steadyState(sinkage);
    sinkage_avg_array(jj) = sinkage_ss.avg;
    sinkage_std_array(jj) = sinkage_ss.dev;

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
    dbp_ss = steadyState(dbp);
    dbp_avg_array(jj) = dbp_ss.avg;
    dbp_std_array(jj) = dbp_ss.dev;
    
    trq = rig_result(:,30);    
    if drawPlots == true
        subplot(3,1,3)
        makePlot(t(1:end), trq(1:end),'time', 'torque (N-m)', '', LW, FS);
        hold on
        grid on
    end
    
    trq_ss = steadyState(trq);
    trq_avg_array(jj) = trq_ss.avg;
    trq_std_array(jj) = trq_ss.dev;
    
end

figure;
subplot(1,3,1)
makeErrorBar(mus_array, sinkage_avg_array*1000, sinkage_std_array*1000, '\mu_s', 'sinkage (mm)', 'HCP, seperation factor 1.001', LW, FS, 'o', MS);
xlim([min(mus_array)-0.1, max(mus_array)+0.1]);
grid on


subplot(1,3,2)
makeErrorBar(mus_array, dbp_avg_array, dbp_std_array, '\mu_s', 'draw bar pull (N)', 'slip ratio 0.5', LW, FS, 'o', MS);
xlim([min(mus_array)-0.1, max(mus_array)+0.1]);
grid on

subplot(1,3,3)
makeErrorBar(mus_array, -trq_avg_array, trq_std_array, '\mu_s', 'torque (Nm)', '', LW, FS, 'o', MS);
xlim([min(mus_array)-0.1, max(mus_array)+0.1]);
grid on