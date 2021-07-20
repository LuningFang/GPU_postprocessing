% =============================================================================
  % SIMULATION-BASED ENGINEERING LAB (SBEL) - http://sbel.wisc.edu
  %
  % Copyright (c) 2019 SBEL
  % All rights reserved.
  %
  % Use of this source code is governed by a BSD-style license that can be found
  % at https://opensource.org/licenses/BSD-3-Clause
  %
  % =============================================================================
  % Contributors: Luning Fang
  % =============================================================================

function varargout =  makeErrorBar(varargin)
switch nargin
    
    case 8
        % 7 input parameters, no need for plot in a plot
        % inputs are, x y coordinate, xlabel, ylabel, title, linewidth and
        % fonsize
        x = varargin{1}; y = varargin{2}; err=varargin{3};
        x_str = varargin{4}; y_str = varargin{5}; title_str = varargin{6};
        LW = varargin{7}; FS = varargin{8};
        handle = errorbar(x, y, err, 'LineWidth', LW);
        if contains(x_str, '$$')
            xlabel(x_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            xlabel(x_str, 'FontSize', FS);
        end

        if contains(y_str, '$$')
            ylabel(y_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            ylabel(y_str, 'FontSize', FS);
        end

        set(gca, 'linewidth', LW);
        a = get(gca, 'XTick');
        set(gca, 'FontSize', FS-3)
        xlim([0,max(x)])
        if contains(title_str, '$$')
            title(title_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            title(title_str, 'FontSize', FS);
        end
        
    case 9
        % 8 input parameters, no need for plot in a plot
        % inputs are, x y coordinate, xlabel, ylabel, title, linewidth,
        % fonsize and plot style
        x = varargin{1}; y = varargin{2}; err=varargin{3};
        x_str = varargin{4}; y_str = varargin{5}; title_str = varargin{6};
        LW = varargin{7}; FS = varargin{8};
        style = varargin{9};
        handle = errorbar(x, y, err, style, 'LineWidth', LW);
        if contains(x_str, '$$')
            xlabel(x_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            xlabel(x_str, 'FontSize', FS);
        end

        if contains(y_str, '$$')
            ylabel(y_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            ylabel(y_str, 'FontSize', FS);
        end

        set(gca, 'linewidth', LW);
        a = get(gca, 'XTick');
        set(gca, 'FontSize', FS-3)
        xlim([0,max(x)])
        if contains(title_str, '$$')
            title(title_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            title(title_str, 'FontSize', FS);
        end

    case 10
        % 9 input parameters, no need for plot in a plot
        % inputs are, x y coordinate, xlabel, ylabel, title, linewidth,
        % fonsize and plot style, and marker size
        x = varargin{1}; y = varargin{2}; err=varargin{3};
        x_str = varargin{4}; y_str = varargin{5}; title_str = varargin{6};
        LW = varargin{7}; FS = varargin{8};
        style = varargin{9}; MS = varargin{10};
        handle = errorbar(x, y, err, style, 'LineWidth', LW, 'MarkerSize', MS);
        if contains(x_str, '$$')
            xlabel(x_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            xlabel(x_str, 'FontSize', FS);
        end

        if contains(y_str, '$$')
            ylabel(y_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            ylabel(y_str, 'FontSize', FS);
        end

        set(gca, 'linewidth', LW);
        a = get(gca, 'XTick');
        set(gca, 'FontSize', FS-3)
        xlim([0,max(x)])
        if contains(title_str, '$$')
            title(title_str, 'FontSize', FS, 'Interpreter', 'latex');
        else
            title(title_str, 'FontSize', FS);
        end
end

switch nargout
    case 0
    case 1
        varargout{1} = handle;
end