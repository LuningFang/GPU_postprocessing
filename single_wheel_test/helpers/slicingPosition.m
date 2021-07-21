% return positions of top couple layer of particles where wheel travel
function trucatedPos = slicingPosition(filename)
global particle_diameter

entries = dlmread(filename, ' ');
x_pos = entries(:,2);
y_pos = entries(:,3);
z_pos = entries(:,4);

% entries = csvread(filename, 1, 0);
% x_pos = entries(:,1);
% y_pos = entries(:,2);
% z_pos = entries(:,3);

trucatedPos = [];
z_max = max(z_pos);
layer_bottom = z_max - 3* particle_diameter;
for i = 1:length(x_pos)
    x = x_pos(i);
    y = y_pos(i);
    z = z_pos(i);
    
    if abs(y) <= particle_diameter && z > layer_bottom
        trucatedPos = [trucatedPos; x y z];
    end
end
end