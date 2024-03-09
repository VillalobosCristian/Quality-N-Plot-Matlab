function Nplot_figure_tiledlayout(figureHandle, numPlotsPerRow, numRows, varargin)

% Function to format figures for PNAS template using tiledlayout
%
% Description:
%   This function formats figures for the PNAS (Proceedings of the National
%   Academy of Sciences) template using the tiledlayout function in MATLAB.
%   It allows customization of various aspects of the figure, such as font
%   size, line width, marker size, colors, axis scales, and more.
%
% Input:
%   - figureHandle: Handle to the figure to be formatted.
%   - numPlotsPerRow: Number of plots per row in the tiled layout (1 to 4).
%   - numRows: Number of rows in the tiled layout.
%   - varargin: Optional parameter-value pairs for customization.
%
% Optional Parameters:
%   - 'FontName': Font name (default: 'Arial').
%   - 'FontSize': Base font size (default: 6).
%   - 'LineWidth': Line width (default: 0.5).
%   - 'MarkerSize': Marker size (default: 6).
%   - 'LineColor': Color of lines (default: 'k').
%   - 'MarkerColor': Color of markers (default: 'k').
%   - 'AxisColor': Color of axis labels (default: 'k').
%   - 'BackupFont': Backup font if the specified font is not available (default: 'Helvetica').
%   - 'PlotHeight': Height of each plot in centimeters (default: 6).
%   - 'AspectRatio': Width/height ratio of each plot (default: 1.45).
%   - 'TileSpacing': Spacing between tiles (default: 'compact').
%   - 'Padding': Padding around tiles (default: 'compact').
%   - 'LabelFontSize': Font size for labels (default: base font size).
%   - 'TitleFontSize': Font size for titles (default: base font size + 1).
%   - 'ColorbarLabel': Label for the colorbar (default: '').
%   - 'ColorbarLabelInterpreter': Interpreter for the colorbar label (default: 'latex').
%   - 'LegendInterpreter': Interpreter for the legend (default: 'latex').
%   - 'LegendFontSize': Font size for legend (default: base font size).
%   - 'LegendLocation': Location of the legend (default: 'best').
%   - 'PlotType': Type of plot ('plot', 'scatter', 'loglog', 'plot3', 'semilogx', 'semilogy', 'bar', 'histogram') (default: 'plot').
%   - 'XScale': Scale for the x-axis ('linear', 'log') (default: 'linear').
%   - 'YScale': Scale for the y-axis ('linear', 'log') (default: 'linear').
%   - 'ZScale': Scale for the z-axis ('linear', 'log') (default: 'linear').
%   - 'AxisLabelStyle': Style of the axis labels ('normal', 'bold', 'italic', 'bold italic') (default: 'normal').
%   - 'AxisLabelColor': Color of the axis labels (default: 'k').
%   - 'AxisLabelOrientation': Orientation of the axis labels ('horizontal', 'vertical') (default: 'horizontal').
%   - 'TitleStyle': Style of the plot titles ('normal', 'bold', 'italic', 'bold italic') (default: 'normal').
%   - 'TitleColor': Color of the plot titles (default: 'k').
%   - 'StyleProfile': Predefined style profile ('default', 'custom') (default: 'default').
%
% Output:
%   The function formats the specified figure according to the PNAS template
%   and the provided customization options. The formatted figure is displayed
%   in the MATLAB figure window.
%
% Example:
%   fig = figure;
%   pnas_figure_tiledlayout(fig, 2, 2, 'FontName', 'Times New Roman', 'FontSize', 8, 'LineWidth', 1);
%
% Note:
%   - The function assumes that the figure handle is valid and corresponds to an existing figure.
%   - The function uses the tiledlayout function, which requires MATLAB R2019b or later.
%   - It is recommended to test the function with different parameter combinations and MATLAB versions to ensure compatibility.
%
% Author:
%   [Your Name]
%
% Date:
%   [Current Date]
p = inputParser;
addParameter(p, 'FontName', 'Arial', @ischar);
addParameter(p, 'FontSize', 6, @isnumeric);
addParameter(p, 'LineWidth', 0.5, @isnumeric);
addParameter(p, 'MarkerSize', 6, @isnumeric);
addParameter(p, 'LineColor', 'k', @ischar);
addParameter(p, 'MarkerColor', 'k', @ischar);
addParameter(p, 'AxisColor', 'k', @ischar);
addParameter(p, 'BackupFont', 'Helvetica', @ischar);
addParameter(p, 'PlotHeight', 6, @isnumeric);
addParameter(p, 'AspectRatio', 1.45, @isnumeric);
addParameter(p, 'TileSpacing', 'compact', @ischar);
addParameter(p, 'Padding', 'compact', @ischar);
addParameter(p, 'LabelFontSize', [], @isnumeric);
addParameter(p, 'TitleFontSize', [], @isnumeric);
addParameter(p, 'ColorbarLabel', '', @ischar);
addParameter(p, 'ColorbarLabelInterpreter', 'latex', @ischar);
addParameter(p, 'LegendInterpreter', 'latex', @ischar);
addParameter(p, 'LegendFontSize', [], @isnumeric);
addParameter(p, 'LegendLocation', 'best', @ischar);
addParameter(p, 'PlotType', 'plot', @ischar);
addParameter(p, 'XScale', 'linear', @ischar);
addParameter(p, 'YScale', 'linear', @ischar);
addParameter(p, 'ZScale', 'linear', @ischar);
addParameter(p, 'AxisLabelStyle', 'normal', @ischar);
addParameter(p, 'AxisLabelColor', 'k', @ischar);
addParameter(p, 'AxisLabelOrientation', 'horizontal', @ischar);
addParameter(p, 'TitleStyle', 'normal', @ischar);
addParameter(p, 'TitleColor', 'k', @ischar);
addParameter(p, 'StyleProfile', 'default', @ischar);
addParameter(p, 'ColorbarLocation', 'northoutside', @ischar);
parse(p, varargin{:});
params = p.Results;

% Adjust font sizes for labels and titles if not specified
if isempty(params.LabelFontSize)
    params.LabelFontSize = params.FontSize;
end
if isempty(params.TitleFontSize)
    params.TitleFontSize = params.FontSize + 1;
end
if isempty(params.LegendFontSize)
    params.LegendFontSize = params.FontSize;
end

% Validate figure handle
if ~ishandle(figureHandle) || ~strcmp(get(figureHandle, 'Type'), 'figure')
    error('Invalid figure handle.');
end

% Check if the specified font is available, else use the backup font
if ~any(strcmp(listfonts, params.FontName))
    warning('Font "%s" is not available. Using backup font "%s" instead.', params.FontName, params.BackupFont);
    params.FontName = params.BackupFont;
end

% Set initial figure size and properties
setFigureSizeAndProperties(figureHandle, numPlotsPerRow, numRows, params);

% Create tiled layout
tl = tiledlayout(figureHandle, numRows, numPlotsPerRow, 'TileSpacing', params.TileSpacing, 'Padding', params.Padding);

% Adjust each plot within the layout
adjustPlotsInLayout(tl, params);

% Accommodate colorbar at the top, adjusting figure size if necessary
if strcmp(params.ColorbarLocation, 'northoutside')
    accommodateTopColorbar(figureHandle, tl, params);
end
end

function setFigureSizeAndProperties(figureHandle, numPlotsPerRow, numRows, params)
% Calculate and set the figure size based on the number of plots and their aspect ratio
plotWidth = params.PlotHeight * params.AspectRatio;
figureWidth = plotWidth * numPlotsPerRow;
figureHeight = params.PlotHeight * numRows;

% Adjust figure properties
set(figureHandle, 'Units', 'centimeters');
figPos = get(figureHandle, 'Position');
set(figureHandle, 'Position', [figPos(1), figPos(2), figureWidth, figureHeight], ...
    'PaperUnits', 'centimeters', ...
    'PaperPosition', [0, 0, figureWidth, figureHeight], ...
    'PaperSize', [figureWidth, figureHeight], ...
    'Color', 'w');
end

function adjustPlotsInLayout(tl, params)
% Set properties for each plot in the layout
% Get all axes in the tiled layout
axesInLayout = findobj(tl, 'Type', 'Axes');

% Adjust properties for each axis
for axesHandle = axesInLayout'
    set(axesHandle, 'FontName', params.FontName, 'FontSize', params.FontSize, ...
        'LineWidth', params.LineWidth, 'Color', params.AxisColor, ...
        'TickDir', 'out', 'TickLength', [0.02, 0.02], ...
        'XColor', params.AxisColor, 'XMinorTick', 'on', ...
        'YColor', params.AxisColor, 'YMinorTick', 'on', ...
        'ZColor', params.AxisColor, 'ZMinorTick', 'on', 'TickDir', 'out', 'box', 'on');

    % Set the scale for each axis
    set(axesHandle, 'XScale', params.XScale, 'YScale', params.YScale, 'ZScale', params.ZScale);

    % Set line and marker properties based on plot type
    if strcmp(params.PlotType, 'scatter')
        markerSizeScatter = floor(pi * (params.MarkerSize / 4) ^ 2);
        set(axesHandle, 'Marker', 'o', 'MarkerSize', markerSizeScatter, ...
            'MarkerEdgeColor', params.MarkerColor, 'MarkerFaceColor', params.MarkerColor);
    elseif strcmp(params.PlotType, 'loglog')
        set(axesHandle, 'XScale', 'log', 'YScale', 'log');
    elseif strcmp(params.PlotType, 'plot3')
        set(axesHandle, 'ZColor', params.AxisColor, 'ZMinorTick', 'on');
    elseif strcmp(params.PlotType, 'semilogx')
        set(axesHandle, 'XScale', 'log');
    elseif strcmp(params.PlotType, 'semilogy')
        set(axesHandle, 'YScale', 'log');
    end

    lines = findobj(axesHandle, 'Type', 'Line');
    for j = 1:length(lines)
        set(lines(j), 'LineWidth', params.LineWidth, 'Color', params.LineColor);
    end

    % Add grid lines
    grid(axesHandle, 'off');

    % Set the aspect ratio of each plot
    pbaspect(axesHandle, [params.AspectRatio, 1, 1]);

    % Adjust colorbar properties (if present)
    colorbarHandle = findobj(axesHandle, 'Type', 'Colorbar');
    if ~isempty(colorbarHandle)
        set(colorbarHandle, 'FontName', params.FontName, 'FontSize', params.FontSize, ...
            'LineWidth', params.LineWidth, 'Color', params.AxisColor);
        colorbarHandle.Label.FontSize = params.LabelFontSize;
        colorbarHandle.Label.Interpreter = params.ColorbarLabelInterpreter;
        colorbarHandle.Label.String = params.ColorbarLabel;
    end

    % Adjust title font size, style, and color
    title = get(axesHandle, 'Title');
    set(title, 'FontSize', params.TitleFontSize, 'FontWeight', params.TitleStyle, 'Color', params.TitleColor);

    % Adjust legend properties (if present)
    legendHandle = findobj(axesHandle, 'Type', 'Legend');
    if ~isempty(legendHandle)
        set(legendHandle, 'FontName', params.FontName, 'FontSize', params.LegendFontSize, ...
            'LineWidth', params.LineWidth, 'EdgeColor', params.AxisColor, 'Color', 'none', ...
            'Interpreter', params.LegendInterpreter, 'Location', params.LegendLocation);
    end

    % Adjust axis label font size, style, color, and orientation
    xLabel = get(axesHandle, 'XLabel');
    yLabel = get(axesHandle, 'YLabel');
    zLabel = get(axesHandle, 'ZLabel');
    set([xLabel, yLabel, zLabel], 'FontSize', params.LabelFontSize, 'FontWeight', params.AxisLabelStyle, ...
        'Color', params.AxisLabelColor);
end

% Adjust text properties
textHandles = findobj(tl, 'Type', 'Text');
for i = 1:length(textHandles)
    set(textHandles(i), 'FontName', params.FontName, 'FontSize', params.FontSize, 'Color', params.AxisColor);
end
end

function accommodateTopColorbar(figureHandle, tl, params)
% Adjust figure and tiled layout size to include a colorbar at the top
% Estimate additional space required for the colorbar
colorbarHeight = params.PlotHeight * 0.2; % Example factor, adjust based on actual colorbar size

% Get current figure dimensions
figPos = get(figureHandle, 'Position');

% Update figure height to accommodate the colorbar
newFigHeight = figPos(4) + colorbarHeight;
set(figureHandle, 'Position', [figPos(1), figPos(2), figPos(3), newFigHeight]);

% Update tiled layout to fill the figure except for colorbar space
set(tl, 'InnerPosition', [0, 0, 1, (figPos(4) / newFigHeight)]);
end

%% Example


function Nplot_figure_tiledlayout(figureHandle, numPlotsPerRow, numRows, varargin)

    % Function to format figures for PNAS template using tiledlayout
    %
    % Description:
    %   This function formats figures for the PNAS (Proceedings of the National
    %   Academy of Sciences) template using the tiledlayout function in MATLAB.
    %   It allows customization of various aspects of the figure, such as font
    %   size, line width, marker size, colors, axis scales, and more.
    %
    % Input:
    %   - figureHandle: Handle to the figure to be formatted.
    %   - numPlotsPerRow: Number of plots per row in the tiled layout (1 to 4).
    %   - numRows: Number of rows in the tiled layout.
    %   - varargin: Optional parameter-value pairs for customization.
    %
    % Optional Parameters:
    %   - 'FontName': Font name (default: 'Arial').
    %   - 'FontSize': Base font size (default: 6).
    %   - 'LineWidth': Line width (default: 0.5).
    %   - 'MarkerSize': Marker size (default: 6).
    %   - 'LineColor': Color of lines (default: 'k').
    %   - 'MarkerColor': Color of markers (default: 'k').
    %   - 'AxisColor': Color of axis labels (default: 'k').
    %   - 'BackupFont': Backup font if the specified font is not available (default: 'Helvetica').
    %   - 'PlotHeight': Height of each plot in centimeters (default: 6).
    %   - 'AspectRatio': Width/height ratio of each plot (default: 1.45).
    %   - 'TileSpacing': Spacing between tiles (default: 'compact').
    %   - 'Padding': Padding around tiles (default: 'compact').
    %   - 'LabelFontSize': Font size for labels (default: base font size).
    %   - 'TitleFontSize': Font size for titles (default: base font size + 1).
    %   - 'ColorbarLabel': Label for the colorbar (default: '').
    %   - 'ColorbarLabelInterpreter': Interpreter for the colorbar label (default: 'latex').
    %   - 'LegendInterpreter': Interpreter for the legend (default: 'latex').
    %   - 'LegendFontSize': Font size for legend (default: base font size).
    %   - 'LegendLocation': Location of the legend (default: 'best').
    %   - 'PlotType': Type of plot ('plot', 'scatter', 'loglog', 'plot3', 'semilogx', 'semilogy', 'bar', 'histogram') (default: 'plot').
    %   - 'XScale': Scale for the x-axis ('linear', 'log') (default: 'linear').
    %   - 'YScale': Scale for the y-axis ('linear', 'log') (default: 'linear').
    %   - 'ZScale': Scale for the z-axis ('linear', 'log') (default: 'linear').
    %   - 'AxisLabelStyle': Style of the axis labels ('normal', 'bold', 'italic', 'bold italic') (default: 'normal').
    %   - 'AxisLabelColor': Color of the axis labels (default: 'k').
    %   - 'AxisLabelOrientation': Orientation of the axis labels ('horizontal', 'vertical') (default: 'horizontal').
    %   - 'TitleStyle': Style of the plot titles ('normal', 'bold', 'italic', 'bold italic') (default: 'normal').
    %   - 'TitleColor': Color of the plot titles (default: 'k').
    %   - 'StyleProfile': Predefined style profile ('default', 'custom') (default: 'default').
    %
    % Output:
    %   The function formats the specified figure according to the PNAS template
    %   and the provided customization options. The formatted figure is displayed
    %   in the MATLAB figure window.
    %
    % Example:
    %   fig = figure;
    %   pnas_figure_tiledlayout(fig, 2, 2, 'FontName', 'Times New Roman', 'FontSize', 8, 'LineWidth', 1);
    %
    % Note:
    %   - The function assumes that the figure handle is valid and corresponds to an existing figure.
    %   - The function uses the tiledlayout function, which requires MATLAB R2019b or later.
    %   - It is recommended to test the function with different parameter combinations and MATLAB versions to ensure compatibility.
    %
    % Author:
    %   [Your Name]
    %
    % Date:
    %   [Current Date]
    p = inputParser;
    addParameter(p, 'FontName', 'Arial', @ischar);
    addParameter(p, 'FontSize', 6, @isnumeric);
    addParameter(p, 'LineWidth', 0.5, @isnumeric);
    addParameter(p, 'MarkerSize', 6, @isnumeric);
    addParameter(p, 'LineColor', 'k', @ischar);
    addParameter(p, 'MarkerColor', 'k', @ischar);
    addParameter(p, 'AxisColor', 'k', @ischar);
    addParameter(p, 'BackupFont', 'Helvetica', @ischar);
    addParameter(p, 'PlotHeight', 6, @isnumeric);
    addParameter(p, 'AspectRatio', 1.45, @isnumeric);
    addParameter(p, 'TileSpacing', 'compact', @ischar);
    addParameter(p, 'Padding', 'compact', @ischar);
    addParameter(p, 'LabelFontSize', [], @isnumeric);
    addParameter(p, 'TitleFontSize', [], @isnumeric);
    addParameter(p, 'ColorbarLabel', '', @ischar);
    addParameter(p, 'ColorbarLabelInterpreter', 'latex', @ischar);
    addParameter(p, 'LegendInterpreter', 'latex', @ischar);
    addParameter(p, 'LegendFontSize', [], @isnumeric);
    addParameter(p, 'LegendLocation', 'best', @ischar);
    addParameter(p, 'PlotType', 'plot', @ischar);
    addParameter(p, 'XScale', 'linear', @ischar);
    addParameter(p, 'YScale', 'linear', @ischar);
    addParameter(p, 'ZScale', 'linear', @ischar);
    addParameter(p, 'AxisLabelStyle', 'normal', @ischar);
    addParameter(p, 'AxisLabelColor', 'k', @ischar);
    addParameter(p, 'AxisLabelOrientation', 'horizontal', @ischar);
    addParameter(p, 'TitleStyle', 'normal', @ischar);
    addParameter(p, 'TitleColor', 'k', @ischar);
    addParameter(p, 'StyleProfile', 'default', @ischar);
    addParameter(p, 'ColorbarLocation', 'northoutside', @ischar);
    parse(p, varargin{:});
    params = p.Results;

    % Adjust font sizes for labels and titles if not specified
    if isempty(params.LabelFontSize)
        params.LabelFontSize = params.FontSize;
    end
    if isempty(params.TitleFontSize)
        params.TitleFontSize = params.FontSize + 1;
    end
    if isempty(params.LegendFontSize)
        params.LegendFontSize = params.FontSize;
    end

    % Validate figure handle
    if ~ishandle(figureHandle) || ~strcmp(get(figureHandle, 'Type'), 'figure')
        error('Invalid figure handle.');
    end

    % Check if the specified font is available, else use the backup font
    if ~any(strcmp(listfonts, params.FontName))
        warning('Font "%s" is not available. Using backup font "%s" instead.', params.FontName, params.BackupFont);
        params.FontName = params.BackupFont;
    end

    % Set initial figure size and properties
    setFigureSizeAndProperties(figureHandle, numPlotsPerRow, numRows, params);

    % Create tiled layout
    tl = tiledlayout(figureHandle, numRows, numPlotsPerRow, 'TileSpacing', params.TileSpacing, 'Padding', params.Padding);

    % Adjust each plot within the layout
    adjustPlotsInLayout(tl, params);

    % Accommodate colorbar at the top, adjusting figure size if necessary
    if strcmp(params.ColorbarLocation, 'northoutside')
        accommodateTopColorbar(figureHandle, tl, params);
    end
    end

    function setFigureSizeAndProperties(figureHandle, numPlotsPerRow, numRows, params)
    % Calculate and set the figure size based on the number of plots and their aspect ratio
    plotWidth = params.PlotHeight * params.AspectRatio;
    figureWidth = plotWidth * numPlotsPerRow;
    figureHeight = params.PlotHeight * numRows;

    % Adjust figure properties
    set(figureHandle, 'Units', 'centimeters');
    figPos = get(figureHandle, 'Position');
    set(figureHandle, 'Position', [figPos(1), figPos(2), figureWidth, figureHeight], ...
        'PaperUnits', 'centimeters', ...
        'PaperPosition', [0, 0, figureWidth, figureHeight], ...
        'PaperSize', [figureWidth, figureHeight], ...
        'Color', 'w');
    end

    function adjustPlotsInLayout(tl, params)
    % Set properties for each plot in the layout
    % Get all axes in the tiled layout
    axesInLayout = findobj(tl, 'Type', 'Axes');

    % Adjust properties for each axis
    for axesHandle = axesInLayout'
        set(axesHandle, 'FontName', params.FontName, 'FontSize', params.FontSize, ...
            'LineWidth', params.LineWidth, 'Color', params.AxisColor, ...
            'TickDir', 'out', 'TickLength', [0.02, 0.02], ...
            'XColor', params.AxisColor, 'XMinorTick', 'on', ...
            'YColor', params.AxisColor, 'YMinorTick', 'on', ...
            'ZColor', params.AxisColor, 'ZMinorTick', 'on', 'TickDir', 'out', 'box', 'on');

        % Set the scale for each axis
        set(axesHandle, 'XScale', params.XScale, 'YScale', params.YScale, 'ZScale', params.ZScale);

        % Set line and marker properties based on plot type
        if strcmp(params.PlotType, 'scatter')
            markerSizeScatter = floor(pi * (params.MarkerSize / 4) ^ 2);
            set(axesHandle, 'Marker', 'o', 'MarkerSize', markerSizeScatter, ...
                'MarkerEdgeColor', params.MarkerColor, 'MarkerFaceColor', params.MarkerColor);
        elseif strcmp(params.PlotType, 'loglog')
            set(axesHandle, 'XScale', 'log', 'YScale', 'log');
        elseif strcmp(params.PlotType, 'plot3')
            set(axesHandle, 'ZColor', params.AxisColor, 'ZMinorTick', 'on');
        elseif strcmp(params.PlotType, 'semilogx')
            set(axesHandle, 'XScale', 'log');
        elseif strcmp(params.PlotType, 'semilogy')
            set(axesHandle, 'YScale', 'log');
        end

        lines = findobj(axesHandle, 'Type', 'Line');
        for j = 1:length(lines)
            set(lines(j), 'LineWidth', params.LineWidth, 'Color', params.LineColor);
        end

        % Add grid lines
        grid(axesHandle, 'off');

        % Set the aspect ratio of each plot
        pbaspect(axesHandle, [params.AspectRatio, 1, 1]);

        % Adjust colorbar properties (if present)
        colorbarHandle = findobj(axesHandle, 'Type', 'Colorbar');
        if ~isempty(colorbarHandle)
            set(colorbarHandle, 'FontName', params.FontName, 'FontSize', params.FontSize, ...
                'LineWidth', params.LineWidth, 'Color', params.AxisColor);
            colorbarHandle.Label.FontSize = params.LabelFontSize;
            colorbarHandle.Label.Interpreter = params.ColorbarLabelInterpreter;
            colorbarHandle.Label.String = params.ColorbarLabel;
        end

        % Adjust title font size, style, and color
        title = get(axesHandle, 'Title');
        set(title, 'FontSize', params.TitleFontSize, 'FontWeight', params.TitleStyle, 'Color', params.TitleColor);

        % Adjust legend properties (if present)
        legendHandle = findobj(axesHandle, 'Type', 'Legend');
        if ~isempty(legendHandle)
            set(legendHandle, 'FontName', params.FontName, 'FontSize', params.LegendFontSize, ...
                'LineWidth', params.LineWidth, 'EdgeColor', params.AxisColor, 'Color', 'none', ...
                'Interpreter', params.LegendInterpreter, 'Location', params.LegendLocation);
        end

        % Adjust axis label font size, style, color, and orientation
        xLabel = get(axesHandle, 'XLabel');
        yLabel = get(axesHandle, 'YLabel');
        zLabel = get(axesHandle, 'ZLabel');
        set([xLabel, yLabel, zLabel], 'FontSize', params.LabelFontSize, 'FontWeight', params.AxisLabelStyle, ...
            'Color', params.AxisLabelColor);
    end

    % Adjust text properties
    textHandles = findobj(tl, 'Type', 'Text');
    for i = 1:length(textHandles)
        set(textHandles(i), 'FontName', params.FontName, 'FontSize', params.FontSize, 'Color', params.AxisColor);
    end
    end

    function accommodateTopColorbar(figureHandle, tl, params)
    % Adjust figure and tiled layout size to include a colorbar at the top
    % Estimate additional space required for the colorbar
    colorbarHeight = params.PlotHeight * 0.2; % Example factor, adjust based on actual colorbar size

    % Get current figure dimensions
    figPos = get(figureHandle, 'Position');

    % Update figure height to accommodate the colorbar
    newFigHeight = figPos(4) + colorbarHeight;
    set(figureHandle, 'Position', [figPos(1), figPos(2), figPos(3), newFigHeight]);

    % Update tiled layout to fill the figure except for colorbar space
    set(tl, 'InnerPosition', [0, 0, 1, (figPos(4) / newFigHeight)]);
    end



    function Nplot_figure_tiledlayout(figureHandle, numPlotsPerRow, numRows, varargin) A versatile function for creating publication-quality figures with multiple plots

    I often found myself spending countless hours trying to create figures that met the strict formatting guidelines of various scientific journals. It was a tedious and time-consuming process, especially when dealing with multiple plots within a single figure. That's when I decided to take matters into my own hands and develop a MATLAB function that would streamline the figure preparation process, specifically tailored to the requirements of journals.

    One of the **key** features I incorporated was the ability to accommodate a top colorbar, seamlessly integrated into the figure layout. This addition proved to be invaluable for many research projects, allowing for clear and concise representation of data without affecting the **aspect ratio** of the figure.

    Feel free to explore the capabilities of the function, open issues, and share ideas, customize it to suit your specific needs.


    ## Example

    This example demonstrates how to create a figure with multiple subplots using the `Nplot_figure_tiledlayout` function and MATLAB's `tiledlayout` function.

    ```MATLAB


    figureHandle = figure;

    % Set the number of plots per row and number of rows

    numPlotsPerRow = 4;

    numRows = 4;



    Nplot_figure_tiledlayout(gcf, numPlots,numRows);

    tiledlayout(numRows, numPlotsPerRow, 'TileSpacing', 'compact', 'Padding', 'compact');

    % Add different types of plots to each subplot

    for i = 1:numPlotsPerRow*numRows

        nexttile;

        switch i

            case 1 % Line plot

                x = linspace(0, 2*pi, 100);

                y = sin(x);

                plot(x, y);

                title('Line Plot');

                xlabel('X');

                ylabel('Y');

            case 2 % Scatter plot

                x = rand(50, 1);

                y = rand(50, 1);

                scatter(x, y);

                title('Scatter Plot');

                xlabel('X');

                ylabel('Y');

            case 3 % Bar plot

                x = categorical({'A', 'B', 'C', 'D', 'E'});

                y = [2, 4, 6, 8, 10];

                bar(x, y);

                title('Bar Plot');

                xlabel('Category');

                ylabel('Value');

            case 4 % Histogram

                data = randn(1000, 1);

                histogram(data);

                title('Histogram');

                xlabel('Value');

                ylabel('Frequency');

            case 5 % Stem plot

                x = linspace(0, 2*pi, 20);

                y = cos(x);

                stem(x, y);

                title('Stem Plot');

                xlabel('X');

                ylabel('Y');

            case 6 % Stair plot

                x = linspace(0, 2*pi, 20);

                y = sin(x);

                stairs(x, y);

                title('Stair Plot');

                xlabel('X');

                ylabel('Y');

            case 7 % Area plot

                x = linspace(0, 2*pi, 100);

                y1 = sin(x);

                y2 = cos(x);

                area(x, y1);

                hold on;

                area(x, y2);

                hold off;

                title('Area Plot');

                xlabel('X');

                ylabel('Y');

            case 8 % Pie chart

                data = [30, 15, 45, 10];

                pie(data);

                title('Pie Chart');

            case 9 % Heatmap

                data = rand(5, 5);

                heatmap(data);

                title('Heatmap');

            case 10 % Contour plot

                [X, Y] = meshgrid(linspace(-2, 2, 50));

                Z = X.^2 + Y.^2;

                contour(X, Y, Z);

                title('Contour Plot');

                xlabel('X');

                ylabel('Y');

            case 11 % Surface plot

                [X, Y] = meshgrid(linspace(-2, 2, 50));

                Z = X.*exp(-X.^2 - Y.^2);

                surf(X, Y, Z);

                title('Surface Plot');

                xlabel('X');

                ylabel('Y');

                zlabel('Z');

            case 12 % Quiver plot

                [X, Y] = meshgrid(linspace(-2, 2, 10));

                U = sin(X);

                V = cos(Y);

                quiver(X, Y, U, V);

                title('Quiver Plot');

                xlabel('X');

                ylabel('Y');

            case 13 % Polar plot

                theta = linspace(0, 2*pi, 100);

                rho = sin(2*theta).*cos(2*theta);

                polarplot(theta, rho);

                title('Polar Plot');

            case 14 % Error bar plot

                x = 1:5;

                y = [2, 4, 6, 8, 10];

                err = [0.5, 0.8, 1.2, 0.6, 0.9];

                errorbar(x, y, err);

                title('Error Bar Plot');

                xlabel('X');

                ylabel('Y');

            case 15 % Boxplot

                data = rand(100, 3);

                boxplot(data);

                title('Boxplot');

                xlabel('Group');

                ylabel('Value');

            case 16 % Violin plot

                data = rand(100, 3);

                boxplot(data);

                title('Violin Plot');

                xlabel('Group');

                ylabel('Value');

        end

    end

    fileName = 'data_plots';

    print(gcf, fileName, '-dpng', '-r600');

    export_fig 'mi_grafico.pdf' -pdf -transparent -painters -r300
