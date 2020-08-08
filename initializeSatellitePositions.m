function positions = initializeSatellitePositions(N, n)
%   returns：the matrix of size num_of_orbit * num_of_satellites_each,
%   storing satellites position(with respect to their orbit).
%   the j th satellite in the i th orbit is assigned  with th index Mij(M denotes the matrix)
%   satellite position can be determined by γ(in radian), the angle rotated in the 
%   plane(measured counterclockwise), which this matrix's entries store.

%   for the definition of γ, please refer to the specification txt.
%
%   N : num of orbits. n : num of satellites in each orbit.

%   Use the repmat function to preallocate space. 
positions = repmat(-1, N, n);
%   for loop that assigns the initial position
for i = 1 : N
    % satellites are equally spaced, so can use the linspace function
    positions(i,:) = linspace(0, 2 * pi * (1 - 1 / n), n);
end

end

