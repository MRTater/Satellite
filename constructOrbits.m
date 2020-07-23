function orbits = constructOrbits(orbitHeight,num_of_orbit,num_of_satellites_each,input_polar_angle,input_azimuthal_angle)
%   struct array that storing orbit data. 

%   Use the repmat function to preallocate space. 
orbits = repmat(struct('height', 0, 'polar', 0, 'azim', 0, 'num_satellite', 0), 1, num_of_orbit);

%   Use the add_an_orbit function to assign the data.
for i = 1 : num_of_orbit
    orbits(i) = add_an_orbit(orbitHeight, input_polar_angle(i), input_azimuthal_angle, num_of_satellites_each);
end

end

