function [available, distance] = SatelliteDistance(h, polar1, polar2)
%SatelliteDistance  : calculate the distance of two satellites
%   h : orbit height
%   receive the polar coordinates of two satellites
%   convert to Cartesian coordinate first, then calculate the distance
%   if the distance between two satellites is too long that their
%   communication is blocked, available = 0, otherwise available = 1
global r;
d_max = 2 * sqrt(h^2 + 2 * r * h);  % max communicating distance 

% [x y z] = sph2cart(azimuth polar r) correspondingly.
[cartesian1(1), cartesian1(2), cartesian1(3)] = sph2cart(polar1(3), polar1(2), polar1(1));
[cartesian2(1), cartesian2(2), cartesian2(3)] = sph2cart(polar2(3), polar2(2), polar2(1));

distance = pdist([cartesian1; cartesian2], 'euclidean');    % the fuction calculates the distance
if distance > d_max
    available = 0;
else
    available = 1;
end

end

