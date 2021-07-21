function z_profile = find_initial_height(wheel_x, positions)
global particle_diameter

x_pos = positions(:,1);
z_pos = positions(:,3);
trucatedZ = [];
for i = 1:length(x_pos)
    x = x_pos(i);
    z = z_pos(i);
    
    if abs(wheel_x - x) < particle_diameter
        trucatedZ = [trucatedZ; z];
    end
end

if size(trucatedZ) == 0
    fprintf("wheel position in x direction: %e\n", x);
end

z_profile = max(trucatedZ) + particle_diameter/2;
end
