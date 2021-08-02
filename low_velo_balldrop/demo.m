%close all
% clc
%clear all

% given
figure(1)
addpath('../plot_tools/');
addpath('helpers/');

gravity = 9.8;
threshold_acc = 0.1 * gravity; % threshold for determine collision time

spacing = 1;

filename = '/home/luning/Build/force_model/bin/bc_sphere_result_mur_0.20_velo_1.00ms-1.csv';
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
%depth_array(ii) = depth;
collision_time = t_contact_end - t_contact_start;
collision_time_array(ii) = collision_time;

%peak_acc_array(ii) = max(acc);

fprintf("penetration %.2fcm, collision time %.2f ms, peak acc %.2f\n", depth, collision_time*1000, max(acc));

LW = 2;
FS = 25;
MS = 10;

subplot(3,1,1)
hold on
makePlot(time - t_contact_start, acc, 'time(sec)', 'acceleration(m/s^2)', '', LW, FS);
grid on
xlim([0, 0.12]);

subplot(3,1,2)
hold on
makePlot(time - t_contact_start, velo, 'time(sec)', 'velocity(cm/s)', '', LW, FS)
grid on
xlim([0, 0.12]);

subplot(3,1,3)
hold on
makePlot(time - t_contact_start, position - initial_position, 'time(sec)', 'penetration (cm)', '', LW, FS)
grid on
xlim([0, 0.12]);