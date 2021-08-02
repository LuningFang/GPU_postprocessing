%close all
% clc
%clear all

% given 
figure(1)
addpath('../plot_tools/');
addpath('helpers/');
height_array = 5:18;
depth_array = zeros(size(height_array));

gravity = 9.8;
%threshold_acc = 0.01; % threshold for determine collision time
threshold_acc = 0.1 * gravity; % threshold for determine collision time

spacing = 10;

collision_time_array = zeros(size(height_array));
peak_acc_array = zeros(size(height_array));
for ii = 1:length(height_array)
    filler_height = height_array(ii);
    filename = sprintf('data/result_bcsphere_input_position_%02.0fcm.csv', filler_height);
%    filename = sprintf('data/result_bcsphere_input_position_%02.0fcm.csv', filler_height);
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
subplot(3,1,1)
hold on
hdl = makePlot(height_array, -depth_array, 'fill height (cm)', 'penetration depth(cm)', '', LW, FS, 'o', MS);
xlim([0, 20]);
ylim([0, 8]);
ax = hdl.Parent;
set(ax, 'XTick', 0:2:20)
grid on

subplot(3,1,2)
hold on
hdl = makePlot(height_array, collision_time_array * 1000, 'fill height (cm)', 'collision time(ms)', '', LW, FS, 'o', MS);
xlim([0, 20]);
ylim([0, 200]);
ax = hdl.Parent;
set(ax, 'XTick', 0:2:20)
grid on

subplot(3,1,3)
hold on
hdl = makePlot(height_array, peak_acc_array, 'fill height (cm)', 'peak acceleration (ms^{-2})', '', LW, FS, 'o', MS);
xlim([0, 20]);
%ylim([0, 200]);
ax = hdl.Parent;
set(ax, 'XTick', 0:2:20)
grid on


% result = csvread('data/result_meshsphere_input_position_14cm.csv');
% t = result(:,1);
% penetration = result(:,2);
% velo = result(:,3);
% acc = result(:,4);
%
% subplot(3,1,1)
% hold on
% makePlot(t-t(1), acc, 'time(sec)', 'acceleration(m/s^2)', 'filling height 5cm', LW, FS);
% xlim([0.1,0.3])
% grid on
%
% subplot(3,1,2)
% hold on
% makePlot(t-t(1), velo, 'time(sec)', 'velocity(cm/s)', '', LW, FS)
% xlim([0.1,0.3])
% grid on
%
% subplot(3,1,3)
% hold on
% makePlot(t-t(1), penetration, 'time(sec)', 'penetration (cm)', '', LW, FS)
% xlim([0.1,0.3])
% grid on
