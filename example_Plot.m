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
