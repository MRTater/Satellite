function orbits = constructOrbits(orbitHeight,num_of_orbit,num_of_satellites_each,input_polar_angle,input_azimuthal_angle)
%CONSTRUCTORBIT 此处显示有关此函数的摘要
%   此处显示详细说明
%   struct array that storing orbit data. 

%   Use the repmat function to preallocate space. 
orbits = repmat(struct('height', 0, 'polar', 0, 'azim', 0, 'num_satellite', 0), 1, num_of_orbit);
%   Use the add_an_orbit function to assign the data.
for i = 1 : num_of_orbit
    orbits(i) = add_an_orbit(orbitHeight, input_polar_angle(i), input_azimuthal_angle, num_of_satellites_each);
end

%   the matrix of size num_of_orbit * num_of_satellites_each, storing satellites position(with respect to their orbit)
%   satellite position can be determined by γ(in radian), the angle rotated in the 
%   plane(clockwise), which this matrix's entris store.
%   set that satellites reach z-maximum as γ = 0.

%   Use the repmat function to preallocate space. 
satellite_positions = repmat(-1, num_of_orbit, num_of_satellites_each);
%   for loop that assigns the initial position
for i = 1 : num_of_orbit
    % satellites are equally spaced, so can use the linspace function
    satellite_positions(i,:) = linspace(0, 2 * pi, num_of_satellites_each);
end

