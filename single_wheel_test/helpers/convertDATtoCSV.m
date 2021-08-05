% convert dat style data to csv for paraview to process
% col_start is the column where x_position is
% xlim is a two entry array that 
function convertDATtoCSV(inputFilename, outputFilename, col_start, xlim, topLayerOnly, tireWidthOnly)
entries = dlmread(inputFilename, ' ');
x_pos = entries(:,col_start);
y_pos = entries(:,col_start+1);
z_pos = entries(:,col_start+2);

x_min = xlim(1);
x_max = xlim(2);

index = find(and(x_pos>x_min, x_pos<x_max));
x_pos = x_pos(index);
y_pos = y_pos(index);
z_pos = z_pos(index);

if (topLayerOnly)
    % estimate material depth
    depth = max(z_pos) - min(z_pos);
    minimum_z = max(z_pos) - 0.3 * depth; % only record 40% depth of the material from top
    topLayer_index = find(z_pos>minimum_z);
    x_pos = x_pos(topLayer_index);
    y_pos = y_pos(topLayer_index);
    z_pos = z_pos(topLayer_index);
end

if (tireWidthOnly)
    % get data around the width of the tire, width is 0.08 for cylinder
    index = find(abs(y_pos) <= 0.08);
    x_pos = x_pos(index);
    y_pos = y_pos(index);
    z_pos = z_pos(index);    
end

dlmwrite(outputFilename, 'x, y, z', 'delimiter', '');
dlmwrite(outputFilename, [x_pos y_pos z_pos], '-append', 'delimiter', ',');
fprintf("write %d particles\n", length(x_pos));

plot(x_pos, z_pos, '.')
