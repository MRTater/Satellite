function orbits = constructOrbits(orbitHeight, num_of_satellites_each, input_polar, input_azim)
%   struct array that storing orbit data.
%
%   input_polar : vector that stores all values of the polar angle of
%                 orbits'normal vector.
%   input_polar : vector that stores all values of the polar angle of
%                 orbits'normal vector.

n1 = length(input_azim);
n2 = length(input_polar);
num_of_orbit = n1 * n2;
%   Use the repmat function to preallocate space. 
orbits = repmat(struct('height', 0, 'polar', 0, 'azim', 0, 'num_satellite', 0), 1, num_of_orbit);

%   Use the add_an_orbit function to assign the data.
%   each pair of [i, j] can determine a distinct orbit;
for i = 1 : n1
    for j = 1 : n2
        orbits((i-1) * n2 + j) = add_an_orbit(orbitHeight, input_polar(j), input_azim(i), num_of_satellites_each);
    end
end

end

function S = add_an_orbit(Height, Polar, Azim, Num_satellite)
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

