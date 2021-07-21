close all
clc
clear all

addpath('../plot_tools/');
addpath('helpers/');
close all
height_array = 5:14;
depth_array = zeros(size(height_array));

for ii = 1:length(height_array)
    filler_height = height_array(ii);
    filename = sprintf('data/result_bcsphere_input_position_%02.0fcm.csv', filler_height);
    result = csvread(filename);
    time = result(:,1);
    position = result(:,2);
    velo = result(:,3);
    acc = result(:,4);
    
    [t_contact_start, index_start] = findCollisionStartTime(acc, time);
    
    initial_position = position(index_start);
    
    % throw away useless data
    time = time(index_start:end);
    position = position(index_start:end);
    velo = velo(index_start:end);
    acc = acc(index_start:end);
    
    depth = position(end) - initial_position;    
    depth_array(ii) = depth;
end

LW = 2;
FS = 25;
MS = 10;
hdl = makePlot(height_array, -depth_array, 'fill height (cm)', 'penetration depth(cm)', '', LW, FS, 'o', MS);
xlim([0, 16]);
ylim([0, 8]);
ax = hdl.Parent;
set(ax, 'XTick', 0:2:16)
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
