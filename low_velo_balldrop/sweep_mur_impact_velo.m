%close all
% clc
%clear all

% given
figure(1)
addpath('../plot_tools/');
addpath('helpers/');

gravity = 9.8;
%threshold_acc = 0.01; % threshold for determine collision time
threshold_acc = 0.1 * gravity; % threshold for determine collision time

spacing = 1;

mur=0.2;
directory=sprintf('data/sweep_tests/mur_%.2f/', mur);
impact_velo_array=0.25:0.05:1;

depth_array = zeros(length(impact_velo_array), 1);
collision_time_array = zeros(length(impact_velo_array), 1);
peak_acc_array = zeros(length(impact_velo_array), 1);

for ii = 1:length(impact_velo_array)
    impact_velo = impact_velo_array(ii);
    filename = strcat(directory, sprintf('bc_sphere_result_mur_%.2f_velo_%.2fms-1.csv', mur, impact_velo));
    filename
    result = csvread(filename);
    time = result(1:spacing:end,1);
    position = result(1:spacing:end,2);
    velo = result(1:spacing:end,3);
    acc = result(1:spacing:end,4);
    
    [t_contact_start, index_start] = findCollisionStartTime(acc, time);
    
    initial_position = position(index_start);
    
    % throw away useless data
    time = time(index_start:end);
    position = position(index_start:end);
    velo = velo(index_start:end);
    acc = acc(index_start:end);
    
    [t_contact_end, index_end] = findCollisionEndTime(acc, time, threshold_acc);
    
    depth = position(index_end) - initial_position;
    depth_array(ii) = depth;
    collision_time = t_contact_end - t_contact_start;
    collision_time_array(ii) = collision_time;
    
    peak_acc_array(ii) = max(acc);
end

LW = 2;
FS = 25;
MS = 10;

subplot(1,3,1)
hold on
hdl = makePlot(impact_velo_array, peak_acc_array, 'impact velocity (m/s)', 'peak acceleration (ms^{-2})', '', LW, FS, 'o', MS);
xlim([0, 1.25]);
%ylim([0, 200]);
ax = hdl.Parent;
set(ax, 'XTick', 0:0.25:1.25)
grid on

subplot(1,3,2)
hold on
hdl = makePlot(impact_velo_array, -depth_array, 'impact velocity (m/s)', 'penetration depth(cm)', '', LW, FS, 'o', MS);
xlim([0, 1.25]);
%ylim([0, 8]);
ax = hdl.Parent;
set(ax, 'XTick', 0:0.25:1.25)
grid on

subplot(1,3,3)
hold on
hdl = makePlot(impact_velo_array, collision_time_array * 1000, 'impact velocity (m/s)', 'collision time(ms)', '', LW, FS, 'o', MS);
xlim([0, 1.25]);
%ylim([0, 200]);
ax = hdl.Parent;
set(ax, 'XTick', 0:0.25:1.25)
grid on