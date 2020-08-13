function drawGroundPoints(pointV)
%drawGroundPoints 
%   pointV : struct vector that storing the longitude and latitude of points
%
%   east longitude : positive, west longitude : negative
%   north latitude : positive, south longitude : nagative

global r;   % earth radius

[~, N] = size(pointV);

for i = 1 :N
    
% first calculate cartesian coordinate from the longitude and latitude    
elev = deg2rad(pointV(i).latitude);    
azim = wrapTo2Pi( deg2rad(pointV(i).longitude) );
[x, y, z] = sph2cart(azim, elev, r);

% draw the point
plot3(x, y, z, 'o', ...
               'LineWidth', 3, ...
               'MarkerSize', 15, ...
               'MarkerEdgeColor', 'y', ...
               'MarkerFaceColor', 'r');

end

end

