function num = findNearestSatelliteTESTING(orbit, S_positions, sph)
%   sph : the spherical coordinate of the satellite
%   S_positions : position data of satellites on this orbit
global orbitR;
num_of_satellites = length(S_positions);    % num_of_satellites_each
% the angle between the normal vector of the orbit plane and satellite's position vector
angle = acos( cos(pi/2 - orbit.polar) * cos(sph(2) ) * cos(orbit.azim - sph(3)) + ...
                                                sin(pi/2 - orbit.polar) * sin(sph(2)) );
                                            
% to know which satellite is the nearest, need to calculate the relative 
% position of the 1st satellite on the orbit, with respect to S_ik, described by theta.
% For the definition of theta, please refer to the specification document.
d1 = SatelliteDistance(sph, orbit, S_positions(1));
theta = (2 - (d1 / orbitR)^2) / (2 * sin(angle));
d_2 = SatelliteDistance(sph, orbit, S_positions(2));
d_n = SatelliteDistance(sph, orbit, S_positions(num_of_satellites));
% compare d_2 and d_n to identify which side the nearest S lies in.
% d_n >= d_2, direction == 1, clockwise. Otherwise, direction == 0, counterclockwise.
direction = (d_n >= d_2);

% the central angle formed by two satellites in the orbit
theta_S = 2 * pi / num_of_satellites;                                    

num = 1 - direction * round(theta / theta_S);
num = mod(num - 1, num_of_satellites) + 1;
end

