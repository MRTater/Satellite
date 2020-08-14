function distance = SatelliteDistance(polar1, an_orbit, angle)
%SatelliteDistance  : calculate the distance of two satellites
%   receive the polar coordinates of two satellites
%   if the distance between two satellites is too long that their
%   communication is blocked, set distance to -1.
%
%   modified version. To make function constructNetwork more concise,
%   converting satellite_jn's position into spherical coordinte is 
%   done inside the function.

global d_max;    % max communicating distance between two satellites

polar2 = convert2SphCoordinate(an_orbit, angle);

distance = sqrt( ...      
                    polar1(1)^2 + polar2(1)^2 - 2 * polar1(1) * polar2(1) * ...
                       ( cos(polar1(2)) * cos(polar2(2) ) * cos(polar1(3)-polar2(3)) + ...
                                                     sin(polar1(2)) * sin(polar2(2)) ) ...
                );
if distance > d_max
    distance = -1;
end

% useless codes

% [x y z] = sph2cart(azimuth polar r) correspondingly.
%[cartesian1(1), cartesian1(2), cartesian1(3)] = sph2cart(polar1(3), polar1(2), polar1(1));
%[cartesian2(1), cartesian2(2), cartesian2(3)] = sph2cart(polar2(3), polar2(2), polar2(1));
%distance = pdist([cartesian1; cartesian2], 'euclidean');    % the fuction calculating the distance
end

