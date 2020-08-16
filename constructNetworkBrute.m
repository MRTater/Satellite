function networkM = constructNetworkBrute(orbitM, satelliteM)
%   The version using BRUTE FORCE to initialize
%   （calculate distance between each of two satellites)
%
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

for i = 1 : num_of_orbit
     print = ['constructing : waiting ', num2str(i), ' of totally ',num2str(num_of_satellites_each)];
     disp(print)
    for j = i + 1 : num_of_orbit           % each pair of two orbits
        for k = 1 : num_of_satellites_each     % the k th satellite in the i th orbit, denoted by S_ik
        
            % first calculate the spherical coordinate of S_ik
            sphCoor_ik = convert2SphCoordinate(orbitM(i), satelliteM(i, k));
        
            % get the min distance S_ik to orbit j
            min_D = distance2orbit(orbitM(j), sphCoor_ik);
            if min_D > d_max       % S_ik can not connect with all S in orbit j,                                   
                continue;          % skip to the next.
            end
            
            a = num_of_satellites_each * (i - 1) + k;
            
            for x = 1 : num_of_satellites_each    % the x th satellite in the j th orbit
                
                b = num_of_satellites_each * (j - 1);          % a, b : entry indexes
            
                d = SatelliteDistance(sphCoor_ik, orbitM(j), satelliteM(j, x));
                if d <= d_max
                networkM(a, b + x) = d;
                else
                    continue;
                end  
        
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