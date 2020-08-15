%SatelliteDistance  : calculate the distance between two satellites
%   receive the spherical coordinates of two satellites
%
%   if any satellite lies in the z-axis, its azimuthal angle not existing,
%   sphcoor(3) will be assigned 0, so that this function also works.
%
%   modified version. To make function constructNetwork more concise,
%   converting satellite_jn's position into spherical coordinte is 
%   done inside the function.

angle = 0;

an_orbit.height = 550;
an_orbit.polar = 5*pi/12;
an_orbit.azim = pi/6;

polar1 = [6921 -1.151917306316257 4.712388965483528];

%polar1 = [6921 0 0];

%angle = pi/2;

%an_orbit.polar = pi/2;
%an_orbit.azim = 0;





polar2 = convert2SphCoordinate(an_orbit, angle);

polar2
distance = sqrt( ...      
                    polar1(1)^2 + polar2(1)^2 - 2 * polar1(1) * polar2(1) * ...
                       ( cos(polar1(2)) * cos(polar2(2)) * cos(polar1(3)-polar2(3)) + ...
                                                     sin(polar1(2)) * sin(polar2(2)) ) ...
                )
%ANGLE =  cos(polar1(2)) * cos(polar2(2)) * cos(polar1(3)-polar2(3)) + sin(polar1(2)) * sin(polar2(2)) 

