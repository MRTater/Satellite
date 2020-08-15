function [a, b] = ground2Satellites(pointV, orbitM, satelliteM)
%ground2Satellites 
%   Given the location of the place, says, A, that needs to upload information to the
%   satellite network, the function finds the closest satellite to A.
%   
%   input     pointV : struct vector that storing the longitude and latitude of A 	
%                      east longitude : positive, west longitude : negative
%                      north latitude : positive, south longitude : nagative
%             orbitM : matrix storing orbits data
%             satelliteM : matrix storing satellite position data
%   output    a pair of number [a, b], which means the closest satellite is
%             the j th satellite on the i th orbit.
%
%   if can't find an available satellite, which means the communications between 
%   all satelltes and A are bloccked by the earth curvature, the function
%   will return [-1, -1].

global r;       % earth radius
global d_max;   % max communication between two satellites

%   max_D : max communication distance between a point on the ground and a
%   satelllite.
max_D = d_max / 2;

%   get th spherical coordinate of A.
elevA = deg2rad(pointV.latitude);                    % elevation angle
azimA = wrapTo2Pi( deg2rad(pointV.longitude) );      % azimuthal angle

% the satellite closest to A is that whose projection on the earth is
% closest to A.
% using brute force, the time complexity is O(n), which is acceptable.
available = 0;
min = Inf;  % positive infinity
[row, col] = size(satelliteM);
for i = 1 : row
    for j = 1 : col
        sph = convert2SphCoordinate(orbitM(i), satelliteM(i, j));
        angle = acos( cos(elevA) * cos(sph(2) ) * cos(azimA - sph(3)) + ...
                                                      sin(elevA) * sin(sph(2)) );
        temp = r * angle;
        if temp < min && temp <= max_D
            min = temp;
            a = i;
            b = j;
            available = 1;
        end    
    end
end

if available == 0
    a = -1;
    b = -1;
end

end