

function S = add_an_orbit(Height,Polar, Azim, Num_satellite)
%add_an_orbit Add an orbit to the globe. Return one entry to the "orbits" struct array.
%   Height : orbit height
%   Polar : polar angle. Azim : azimuthal angle, which characterizes 
%   the orbit normal vector. (both are in radian)
%   Num_satellite : the number of satellites on this orbit.
%   The function output S : an one-dimension struct array.

S.height = Height;
S.polar = Polar;
S.azim = Azim;
S.num_satellite = Num_satellite;

end
