close all
clc
clear all

addpath('../plot_tools/');
addpath('helpers/');
close all
filler_height_array = [12 14];
figure;
subplot(3,1,1)
subplot(3,1,2)
subplot(3,1,3)

for ii = 1:length(filler_height_array)
    filler_height = filler_height_array(ii);
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
    
    
    LW = 2;
    FS = 25;
    
    subplot(3,1,1)
    hold on
    makePlot(time - t_contact_start, acc, 'time(sec)', 'acceleration(m/s^2)', sprintf("filling height %.0f cm", filler_height), LW, FS);
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
    
end

lgd = legend('H = 12 cm', 'H = 14 cm');

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
