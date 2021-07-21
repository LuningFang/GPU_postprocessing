global topLayerPositions
addpath('/Users/luning/Sources/projectlets/friction-contact/slide-roll-spin/post_processing');
addpath('helpers');
close all

png_name = strcat('fig/cyl_sweep_mus_slip', '.',  'png');
fig_name = strcat('fig/cyl_sweep_mus_slip', '.',  'fig');

drawTimePlotsFlag = false;
home_dir = 'data/rig_results/';
directory1 = strcat(home_dir, 'mu_r_0.2/');
directory2 = strcat(home_dir, 'mu_s_0.85_mu_r_0.2/');
directory3 = strcat(home_dir, 'mu_s_0.8_mu_r_0.2/');
directory4 = strcat(home_dir, 'mu_s_0.75_mu_r_0.2/');
figPos = [22  343 1405 392];

directory_array = {directory1, directory2, directory3, directory4};
plot_style = {'o', '+', '*', '>'};

numSweeps = length(directory_array);
slip_array = [-0.7 -0.5, -0.3, -0.1, 0.0, 0.1, 0.3, 0.5, 0.7];
numSlipRatios = length(slip_array);

figure('Position', figPos, 'Units', 'pixels');
hold on
LW = 4;
MS = 10;
FS =30;
subplot(1,3,1)
hold on
subplot(1,3,2)
hold on
subplot(1,3,3)
hold on


for jj = 1:numSweeps
    
    directory = directory_array{jj};
    settled_pos_filename = strcat(directory, 'checkpoint_settled.dat');
    topLayerPositions = slicingPosition(settled_pos_filename);
    
    dbp_array = zeros(numSlipRatios, 1);
    trq_array = zeros(numSlipRatios, 1);
    sinkage_array = zeros(numSlipRatios, 1);
    
    for ii = 1:numSlipRatios
        filename = sprintf('slip=%.1f.dat', slip_array(ii));
        [sinkage, dbp, trq] = plotTimeSeries(strcat(directory, filename), drawTimePlotsFlag);
        fprintf('slip ratio = %.1f, dbp = %.2f, trq = %.2f\n', slip_array(ii), dbp.avg, trq.avg);
        dbp_array(ii) = dbp.avg;
        trq_array(ii) =trq.avg;
        sinkage_array(ii) = sinkage.avg;
    end
    plot_label = plot_style{jj};
    subplot(1,3,1)
    hold on
    makePlot(slip_array, dbp_array, 'slip ratio', 'draw bar pull (N)', '', LW, FS, plot_label, MS);
    xlim([min(slip_array), max(slip_array)])
    grid on
    subplot(1,3,2)
    hold on
    makePlot(slip_array, -trq_array, 'slip ratio', 'torque (Nm)', '', LW, FS, plot_label, MS);
    xlim([min(slip_array), max(slip_array)])
    grid on
    subplot(1,3,3)
    hold on
    makePlot(slip_array, sinkage_array*1000, 'slip ratio', 'sinkage (mm)', '', LW, FS, plot_label, MS);
    xlim([min(slip_array), max(slip_array)])
    grid on
    
end

subplot(1,3,3)
lgd = legend('\mu_s = 0.9', '\mu_s = 0.85', '\mu_s = 0.8', '\mu_s = 0.75');
lgd.FontSize = FS-8;
lgd.Location = 'northwest';

saveas(gcf,png_name)
savefig(gcf,fig_name)


