clc
clear all
close all
addpath('helpers');
filedir = '/Users/luning/Sources/granularTests_postprocessing/single_wheel_test/data/sep_1.001/';

mus_array = [0.3 0.4 0.5 0.6 0.7 0.8];
numTests = length(mus_array);
for ii = 1:numTests
    mus = mus_array(ii);
    particle_filename = strcat(filedir, sprintf('mus=%.1f_settled.dat', mus));
    rig_filename = strcat(filedir, sprintf('mus=%.1f.dat', mus));
    
    col_start = 2;
    entries = dlmread(particle_filename, ' ');
    fdat.px = entries(:,col_start);
    fdat.py = entries(:,col_start+1);
    fdat.pz = entries(:,col_start+2);
    
    
    rig_result = dlmread(rig_filename, ' ');
    
    % dlm read gives too many zeros...
    rig_result = rig_result(:,1:2:end);
    t = rig_result(:,1);
    wheel_x = rig_result(:,2);
    wheel_z = rig_result(:,4);
    
    fdat.wheel_pos_x = wheel_x(end);
    fdat.wheel_pos_z = wheel_z(end);
    
    fdat.wheel_R = 0.13;
    fdat.wheel_hwidth = 0.08;
    fdat.p_radius = 0.005;
    
    sinkage = evaluate_sinkage(fdat);
    
    dbp = rig_result(:,14);
    dbp_ss = steadyState(dbp);
    
    trq = rig_result(:,30);
    trq_ss = steadyState(trq);
    
    fprintf("mus=%.1f, sinkage %.2f mm, dbp %.2f %s %.2f N, torque %.2f %s %.2f Nm\n", ...
        mus, sinkage * 1000, dbp_ss.avg, char(177), dbp_ss.dev, -trq_ss.avg, char(177), trq_ss.dev );
end