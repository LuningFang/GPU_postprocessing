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
%home_dir = 'data/slipRatio=0.5/';
home_dir = 'data/varySphereMeshParameters/';
% directory1 = strcat(home_dir, 'mu_r_0.2/');
% directory2 = strcat(home_dir, 'mu_s_0.85_mu_r_0.2/');
% directory3 = strcat(home_dir, 'mu_s_0.8_mu_r_0.2/');
% directory4 = strcat(home_dir, 'mu_s_0.75_mu_r_0.2/');
% figPos = [22  343 1405 392];

% directory_array = {directory1, directory2, directory3, directory4};
% plot_style = {'o', '+', '*', '>'};

% numSweeps = length(directory_array);
% slip_array = [-0.7 -0.5, -0.3, -0.1, 0.0, 0.1, 0.3, 0.5, 0.7];
% numSlipRatios = length(slip_array);
% 
% figure('Position', figPos, 'Units', 'pixels');
% hold on
% LW = 4;
% MS = 10;
% FS =30;
% subplot(1,3,1)
% hold on
% subplot(1,3,2)
% hold on
% subplot(1,3,3)
% hold on

mus_array = [0.7 0.7 0.8 0.8 0.9 0.9];
mur_array = [0.3 0.4 0.3 0.4 0.3 0.4];
numTests = 6;
for jj = 1:numTests
    mus = mus_array(jj);
    mur = mur_array(jj);
    settled_pos_filename = sprintf("data/varySphereMeshParameters/mus=%.1f_mur=%.1f_settled.dat", mus, mur);
    topLayerPositions = slicingPosition(settled_pos_filename, 'dat');
    
    rig_filename = sprintf("data/varySphereMeshParameters/mus=%.1f_mur=%.1f_rig.dat", mus, mur);
    [sinkage, dbp, trq] = plotTimeSeries(rig_filename, drawTimePlotsFlag);
    
    fprintf('mus = %.2f, mur = %.1f, dbp = %.2f, trq = %.2f, sinkage = %.2f %s %.2f mm\n', mus, mur, dbp.avg, trq.avg, sinkage.avg * 1000, char(177), sinkage.dev * 1000);

%     subplot(1,3,1)
%     hold on
%     makePlot(slip_array, dbp_array, 'slip ratio', 'draw bar pull (N)', '', LW, FS, plot_label, MS);
%     xlim([min(slip_array), max(slip_array)])
%     grid on
%     subplot(1,3,2)
%     hold on
%     makePlot(slip_array, -trq_array, 'slip ratio', 'torque (Nm)', '', LW, FS, plot_label, MS);
%     xlim([min(slip_array), max(slip_array)])
%     grid on
%     subplot(1,3,3)
%     hold on
%     makePlot(slip_array, sinkage_array*1000, 'slip ratio', 'sinkage (mm)', '', LW, FS, plot_label, MS);
%     xlim([min(slip_array), max(slip_array)])
%     grid on
    
end

% subplot(1,3,3)
% lgd = legend('\mu_s = 0.9', '\mu_s = 0.85', '\mu_s = 0.8', '\mu_s = 0.75');
% lgd.FontSize = FS-8;
% lgd.Location = 'northwest';
% 
% saveas(gcf,png_name)
% savefig(gcf,fig_name)