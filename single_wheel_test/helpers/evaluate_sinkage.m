function sinkage = evaluate_sinkage(fdat)
p_x_temp = fdat.px;
p_y_temp = fdat.py;
p_z_temp = fdat.pz;

wheel_pos_x = fdat.wheel_pos_x;


index_x = and(p_x_temp >= wheel_pos_x, p_x_temp <= wheel_pos_x+fdat.wheel_R);
index = and(index_x, abs(p_y_temp) <= fdat.wheel_hwidth);
p_z = p_z_temp(index);
sinkage = max(p_z) + fdat.p_radius - (fdat.wheel_pos_z - fdat.wheel_R);