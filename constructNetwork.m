function networkM = constructNetwork(orbitM, satelliteM, num_of_satellites_each, num_of_orbit)
%   接受巨大数组然后创建巨大数组然后传递回主程序效率可以吗
%   assumptions: all orbits are of same height
%                all orbits have same number of satellites
%   input        orbitM : matrix storing orbits data
%                satelliteM : matrix storing satellite position data
%   output       networkM : an adjacency matrix, storing the edge weight of
%                the network graph
%                we can only build and use the upper triangular of networkM, 
%                since M(i, j) and M(j, i ) are identical for undirected
%                graph.
%
%   unavialable entries are of value -1, e.g. too far to communication, or
%   satellites DNE in that position

global d_max;   % max communicating distance between two satellites

N = num_of_orbit * num_of_satellites_each; % # of satellites in total 
networkM = repmat(-1, N, N);               % preallocate space, initialize

thetaS = 2*pi/num_of_satellites_each;      % angle between two satellites

%   construct the network block by block, says, connect all available saetllites
%   between two orbits, which are got by traverse every pair of two orbits 
for i = 1 : num_of_orbit
    for j = i + 1 : num_of_orbit          % each pair of two orbits 
        
        for k = 1 : num_of_satellites_each    % the k th satellite in the i th orbit, denoted by S_ik
            % strategy that build edges between satellite S_ik and all satellites in orbit j 
            
            % first calculate the sphere coordinate of S_ik
            sphCoor_ik = convert2SphCoordinate(orbitM(i), satelliteM(i, k));
            
            % get the max and min distance S_ik to orbit j
            [max_D, min_D] = distance2orbit(orbit(j), sphCoor_ik);
            if min_D > d_max       % S_ik can not connect with all S in orbit j,                                   
                continue;          % skip to the next.
            end
            % find the number of the nearest satellite to S_ik in orbit j
            n = findNearestSatellite(orbitM(j), satelliteM(i, k));
           
            % start initialze the edge length(satellite distance) from the
            % n th satellite, so that can minimize useless trials (means returning an unavilable distance)
            a = num_of_satellites_each * (i - 1) + k;
            b = num_of_satellites_each * (j - 1);          % a, b : entry indexes
            networkM(a, b + n) = SatelliteDistance(sphCoor_ik, orbit(j), satelliteM(j,n));
                             % sphCoor_jn is calculated inside the function
            while(1)
                counter = 
            end
            while(1)
                
            end  
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

% function that calculating the relative position of orbit j's fist
% satellite, with respect to S_ik, which is described by theta. For the
% definition of theta, please refer to the specification document.
function theta = caculateTheta()
end