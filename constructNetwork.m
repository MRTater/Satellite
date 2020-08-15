function networkM = constructNetwork(orbitM, satelliteM)
%   assumptions: all orbits are of same height
%                all orbits have same number of satellites
%   input        orbitM : matrix storing orbits data
%                satelliteM : matrix storing satellite position data
%   output       networkM : an adjacency matrix, storing the edge weight of
%                the network graph (satellite distance)
%                we can only build and use the upper triangular of networkM, 
%                since M(i, j) and M(j, i) are identical for undirected
%                graph.
%
%   unavialable entries are of value -1, e.g. too far to communication, or
%   satellites DNE in that position

global d_max;   % max communicating distance between two satellites
global orbitR;  % orbit radius

[num_of_orbit, num_of_satellites_each] = size(satelliteM);

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
            
            % get the min distance S_ik to orbit j
            min_D = distance2orbit(orbitM(j), sphCoor_ik);
            if min_D > d_max       % S_ik can not connect with all S in orbit j,                                   
                continue;          % skip to the next.
            end
            
            % find the nearest satellite to S_ik in orbit j
            n = findNearestSatellite(orbitM(j), satelliteM(j,:), sphCoor_ik);
           
            % start initialize the edge length(satellite distance) from the
            % n th satellite, so that can minimize useless trials (means returning an unavilable distance)
            a = num_of_satellites_each * (i - 1) + k;
            b = num_of_satellites_each * (j - 1);          % a, b : entry indexes
            networkM(a, b + n) = SatelliteDistance(sphCoor_ik, orbitM(j), satelliteM(j, n));
                             % sphCoor_jn is calculated inside the function
                             
            % initialize edges of nearby satellites of n, break when meet one unavailable
            index = n;
            while(1)
                index = mod(index, num_of_satellites_each) + 1;
                d = SatelliteDistance(sphCoor_ik, orbitM(j), satelliteM(j, index));
                if d > d_max
                    break;
                end
                networkM(a, b + index) = d;
            end
            index = n;
            while(1)
                index = mod(index - 2, num_of_satellites_each) + 1;
                d = SatelliteDistance(sphCoor_ik, orbitM(j), satelliteM(j, index));
                if d > d_max
                    break;
                end
                networkM(a, b + index) = d;
            end  
        end
    end
end

%initialize distance between satellites on the same orbit
for i = 1 : num_of_orbit
    for j = 1 : num_of_satellites_each
            
             a = num_of_satellites_each * (i - 1) + j;
             b = num_of_satellites_each * (i - 1);     % a, b : entry indexes
             
             networkM(a, b + j) = 0;
             index = j;
            while(1)
                index = mod(index, num_of_satellites_each) + 1;
                d = 2 * orbitR * abs( sin( pi * (index - j) / num_of_satellites_each ) );
                if d > d_max
                    break;
                end
                networkM(a, b + index) = d;
            end
             while(1)
                index = mod(index - 2, num_of_satellites_each) + 1;
                d = 2 * orbitR * abs( sin( pi * (index - j) / num_of_satellites_each ) );
                if d > d_max
                    break;
                end
                networkM(a, b + index) = d;
            end  
    end 
end

end

% function that calculating the min distance a satellite to an orbit
% under the assumption that all orbits are of same height
function min_D = distance2orbit(orbit, sph)
%   sph : the spherical coordinate of the satellite
global orbitR;
% the angle between the normal vector of the orbit plane and satellite's position vector
% use the central angle formula 
angle = acos( cos(pi/2 - orbit.polar) * cos(sph(2) ) * cos(orbit.azim - sph(3)) + ...
                                                sin(pi/2 - orbit.polar) * sin(sph(2)) ); 
min_D = orbitR * sqrt(2 - 2 * sin(angle));
end

% function that finds the nearest satellite to S_ik in orbit j
function num = findNearestSatellite(orbit, S_positions, sph)
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
theta = acos( (2 - (d1 / orbitR)^2) / (2 * sin(angle)) );
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