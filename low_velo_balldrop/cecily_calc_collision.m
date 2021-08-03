% INPUT
% -------------------------------------------------------------------------
% fdat = simulation data
% tstep = output time step from the simulations
% grav = gravity
% scale = scaling factor to convert the simulation distance units to m. 
%         For example, scale = 10^3 if the simulation units are in mm, and
%         scale = 1 if the simulation units are already in m
% -------------------------------------------------------------------------


% OUTPUT
% -------------------------------------------------------------------------
% zstop1 = Depth of the projectile at tstop1
% zstop2 = Depth of the projectile at tstop2
% zstop3 = Depth of the projectile at tstop3
% zpeak = Projectile depth at apeak
% vcollision = Projectile velocity at z = 0
% vpeak = Projectile velocity at apeak
% vstop1 = Velocity of projectile at tstop1
% vstop2 = Velocity of projectile at tstop2
% vstop2 = Velocity of projectile at tstop3
% apeak = Max projectile acceleration
% astop1 = Acceleration of the projectile at tstop1
% astop2 = acceleration of the projectile at tstop2
% astop2 = acceleration of the projectile at tstop3
% tstart = Start of collision, corrected so that tstart = 0 when height = 0
% tpeak = Time at apeak
% tstop1 = Total collision time, from z = 0 to z when velocity < 1 cm/s
% tstop2 = Total collision time, from z = 0 to z when velocity < 1 mm/s
% tstop3 = Total collision time, from z = 0 to z when a < 0.1*g mm/s
% -------------------------------------------------------------------------

function [pdat] = calc_collision(fdat, tstep, grav, scale)
% Throw out the first data point if the body is not in freefall
if (fdat.acc_y(1) ~= grav)
    fdat = struct2table(fdat);
    fdat = table2struct(fdat(2:end,:),'ToScalar',true);
end

% Set some temp variables
tempT = fdat.time;
tempP = fdat.pos_m;
tempV = fdat.vel_m;
tempA = fdat.acc_m;

% Set parameters for filtering the data
tstep_exp = 7.11E-4;
tstep_sim = tstep;

sf = 1 / tstep_sim;
cutlow = 0.5 * round((1 / tstep_exp), 1, 'significant'); 
wn = cutlow / (sf / 2);
[g,f] = butter(2, wn, 'low');

% Apply a low-pass filter to the data with a cutoff of 0.5*sf_exp
time = tempT;
pos = tempP;
vel = tempV;
acc = filtfilt(g, f, tempA);

% Define tstart as the step right before the end of freefall
icol = find(diff(tempA) > 1.0E-3);

% Reset the time so that tstart = 0 at icol
time = time - time(icol(1));

% Adjust the projectile's position such that z = 0 at icol
pos = pos - pos(icol(1));

% Find the peak acceleration during collision
apeak = max(acc);
ipeak = find(acc == apeak);
ipeak = ipeak(1);

% Define tstop1 as the vel index where v < 1cm/s and tstop2 where v < 1mm/s
istop1 = find(and(abs(vel) < 0.01 * scale, time >= time(ipeak)));

% Define tstop2 where v < 1mm/s
istop2 = find(and(abs(vel) < 0.001 * scale, time >= time(ipeak)));
if isempty(istop2) 
    istop2 = length(time);
end

% Define tstop3 the same way as in the experiments (more or less...bit of a hack)
istop3 = find(and(acc < 0.1 * abs(grav), time >= time(istop1(1))*0.90));     
if (isempty(istop3))
    istop3 = length(time);
end

% Store all collision parameters in the pdat structure
pdat.vcollision = vel(icol(1));
pdat.zpeak = abs(pos(ipeak));
pdat.zstop1 = abs(pos(istop1(1)));
pdat.zstop2 = abs(pos(istop2(1)));
pdat.zstop3 = abs(pos(istop3(1)));
pdat.vpeak = vel(ipeak);
pdat.vstop1 = vel(istop1(1));
pdat.vstop2 = vel(istop2(1));
pdat.vstop3 = vel(istop3(1));
pdat.apeak = apeak;
pdat.astop1 = acc(istop1(1));
pdat.astop2 = acc(istop2(1));
pdat.astop3 = acc(istop3(1));
pdat.tstart = time(icol(1));
pdat.tpeak = time(ipeak);
pdat.tstop1 = time(istop1(1));
pdat.tstop2 = time(istop2(1));
pdat.tstop3 = time(istop3(1));

end