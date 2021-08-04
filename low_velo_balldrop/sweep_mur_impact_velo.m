close all
clc
clear all

% given
figure(1)
addpath('../plot_tools/');
addpath('helpers/');
impact_velo_array=0.3:0.05:1;
mur_array = [0 0.05, 0.09, 0.2];
plot_style_array = {'g*', 'rd', 'b+', 'ms'};

gravity = 9.8;
simulation_time_step = 1e-4;
unit_scale = 1;
numTests = length(impact_velo_array);
depth_array = zeros(numTests, 1);
collision_time_array = zeros(numTests, 1);
peak_acc_array = zeros(numTests, 1);
actual_collision_velo_array = zeros(numTests, 1);

spacing = 1;

for jj = 1:length(mur_array)
    
    mur = mur_array(jj);
    plot_style = plot_style_array{jj};
    directory = sprintf('data/sweep_tests/mur_%.2f/', mur);
    
    for ii = 1:length(impact_velo_array)
        impact_velo = impact_velo_array(ii);
        filename = strcat(directory, sprintf('bc_sphere_result_mur_%.2f_velo_%.2fms-1.csv', mur, impact_velo));
        filename
        result = csvread(filename);
        fdat.time = result(1:spacing:end,1);
        fdat.pos_m = result(1:spacing:end,2) *0.01; % input data from chrono in cm
        fdat.vel_m = result(1:spacing:end,3);
        fdat.acc_m = result(1:spacing:end,4);
        
        pdat = calc_collision(fdat, simulation_time_step, gravity, unit_scale);
        
        actual_col_velo = abs(pdat.vcollision);
        actual_collision_velo_array(ii) = actual_col_velo;
        depth_array(ii)                 = pdat.zstop3 - pdat.zinit;
        collision_time_array(ii)        = pdat.tstop3 - pdat.tstart;
        peak_acc_array(ii)              = pdat.apeak;
        
    end
    
    LW = 2;
    FS = 25;
    MS = 10;
    
    subplot(1,3,1)
    hold on
    hdl = makePlot(actual_collision_velo_array, peak_acc_array, 'impact velocity (m/s)', 'peak acceleration (ms^{-2})', '', LW, FS, plot_style, MS);
    xlim([0, 1.25]);
    ylim([0, 90]);
    ax = hdl.Parent;
    set(ax, 'XTick', 0:0.25:1.25)
    set(ax, 'YTick', 0:18:90)
    grid on
    if (jj == 4)
        hdl.Color=[1 0.5 0];
    end
    
    subplot(1,3,2)
    hold on
    hdl = makePlot(actual_collision_velo_array, depth_array*100, 'impact velocity (m/s)', 'penetration depth(cm)', '', LW, FS, plot_style, MS);
    xlim([0, 1.25]);
    ylim([0, 6]);
    ax = hdl.Parent;
    set(ax, 'XTick', 0:0.25:1.25)
    set(ax, 'YTick', 0:1.2:6)
    grid on
    if (jj == 4)
        hdl.Color=[1 0.5 0];
    end
    
    
    subplot(1,3,3)
    hold on
    hdl = makePlot(actual_collision_velo_array, collision_time_array * 1000, 'impact velocity (m/s)', 'collision time(ms)', '', LW, FS, plot_style, MS);
    xlim([0, 1.25]);
    ylim([0, 200]);
    ax = hdl.Parent;
    set(ax, 'XTick', 0:0.25:1.25)
    set(ax, 'YTick', 0:40:200)
    grid on
    if (jj == 4)
        hdl.Color=[1 0.5 0];
    end

end
legend('\mu_r = 0', '\mu_r = 0.05', '\mu_r = 0.09', '\mu_r = 0.2');
