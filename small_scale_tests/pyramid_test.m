% script for pyramid test
clc
close all
clear all
result = csvread('data/pyramid_stack.csv',1,0);
addpath('../plot_tools/');
mu_r_array = result(:,1);

numTests = 5;
LW = 3;
FS = 28;
MS = 15;

line_style_array = {'s-', 'd-', '*-', '<-', 'o-'};
figure;
hold on
for ii = 1:numTests
    mc_array = result(:,ii+1);
    makePlot(mu_r_array, mc_array, 'rolling friction \mu_r', 'm^c_{top}', 'pyramid test, C::GPU', LW, FS, line_style_array{ii}, MS);
end
grid on

lgd = legend('gap = 0.2 R', 'gap = 0.25 R', 'gap = 0.3 R', 'gap = 0.35R', 'gap = 0.4R');
lgd.Orientation = 'vertical';
lgd.FontSize = FS - 5;