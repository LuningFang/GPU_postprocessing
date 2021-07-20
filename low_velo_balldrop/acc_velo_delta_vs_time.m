close all
clc

addpath('../../projectlets/friction-contact/slide-roll-spin/post_processing/');
close all

result = csvread('denser_10cm.csv');
t = result(:,1);
penetration = result(:,3);
velo = result(:,4)/100;
acc = result(:,5)/100;

LW = 2;
FS = 25;

figure;
subplot(3,1,1)
makePlot(t-t(1), acc, 'time(sec)', 'acceleration(m/s^2)', 'filling height 5cm', LW, FS);
xlim([0,0.11])
grid on

subplot(3,1,2)
makePlot(t-t(1), velo, 'time(sec)', 'velocity(cm/s)', '', LW, FS)
xlim([0,0.11])
grid on

subplot(3,1,3)
delta_init = 0.4467;
makePlot(t-t(1), -(penetration-delta_init), 'time(sec)', 'penetration (cm)', '', LW, FS)
ylim([-4.5, 0.5])
xlim([0,0.11])
grid on
