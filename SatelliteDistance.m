

function [Avaliable,Distance] = SatelliteDistance(AngleOfTwoOrbit,r,AngleOfr1,AngleOfr2)
%SATELLITE Compute distance between two satellite
 instance = 2 * r^2 * (cos(AngleOfr1) * cos(AngleOfr2) + sin(AngleOfr1) * sin(AngleOfr2) * cos(AngleOfTwoOrbit));
 Distance = sqrt(2 * r ^ 2 - instance)
%  2703.8121 = sqrt((RofEarth + RofSatellite)^2 -(RofEarth)^2)
%  Maximum distance/angle between two satellite
angle = 
 if Distance > 2703.8121 * 2
     Avaliable = -1;
 else
     Avaliable = 1;
end

