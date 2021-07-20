H_array = 5:14;
sphere_radius = 0.5;
result = csvread('input_position_denser.csv', 1, 0);
pos_x = result(:,1);
pos_y = result(:,2);
pos_z = result(:,3);

bottom = min(pos_z) + sphere_radius;

for ii = 1:length(H_array)
    H = H_array(ii);
    top = bottom + H;
    
    
    nb = length(pos_z);
    
    truncate_pos = [];
    for i = 1:nb
        
        particle_z = pos_z(i);
        
        if (particle_z + sphere_radius < top)
            truncate_pos = [truncate_pos; pos_x(i) pos_y(i) pos_z(i)];
        end
        
    end
    
%     scatter3(truncate_pos(:,1), truncate_pos(:,2), truncate_pos(:,3), '.');
    
    fileName = sprintf('input_position_denser_%02dcm.csv', H);
    csvwrite(fileName, truncate_pos);
    fprintf("write file at height %02dcm\n", H);
end
