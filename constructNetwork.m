function networkM = constructNetwork(orbitM, satelliteM, num_of_satellites_each, num_of_orbit)
%   接受巨大数组然后创建巨大数组然后传递回主程序效率可以吗
%   input        orbitM : matrix storing orbits data
%                satelliteM : matrix storing satellite position data
%   output       networkM : an adjacency matrix, storing the edge weight of
%                the network graph
%
%   unavialable entries are of value -1, e.g. too far to communication, or
%   satellites DNE in that position

N = num_of_orbit * num_of_satellites_each; % # of satellites in total 
networkM = repmat(-1, N, N);               % preallocate space, initialize

%   construct the network block by block, says, connect all available saetllites
%   between two orbits, which are got by traverse every pair of two orbits 
for i = 1 : num_of_orbit
    for j = i + 1 : num_of_orbit          % each pair of two orbits 
        
        for k = 1 : num_of_satellites_each    % the k th satellite in the i th orbit, denoted by S_ik
            % strategy that build edges between satellite S_ik and all satellites in orbit j 
            
            % first calculate the sphere coordinate of S_ik
            sphCoor_ik = convert2SphCoordinate(orbitM(i), satelliteM(i, k));
        end
    end
end

end

% function that calculating the max and min distance a satellite to an orbit
% under the assumption that all orbits are of same height
function [max_D, min_D] = distance2orbit(orbit, sph)
%   sph : the spherical coordinate of the satellite
global r;
% the angle between the normal vector of the orbit plane and satellite's position vector
% use the central angle formula 用球心角公式算
angle = acos( cos(orbit.polar) * cos(sph(2) ) * cos(orbit.azim - sph(3)) + ...
                                                sin(orbit.polar) * sin(sph(2)) ); 
max_D = r * sqrt(2 + 2 * sin(angle));
min_D = r * sqrt(2 - 2 * sin(angle));
end
