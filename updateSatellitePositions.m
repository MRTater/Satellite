function inputM = updateSatellitePositions(inputM, t)
% Function that realizes dynamic. 
% works under the assumption that all orbits are of the same height
% updates the matrix that stores satellite positions.
% once satellite positions are updated, we can just call the function
% constructNetwork to update the network graph and then recalculate the
% shortest path.
%
%   inputM, : matrix that stores position data of satellites,
%             storing/modifying angle γ.
%   t : time measured in minutes.

% the angulr velocities of satellites
w_E = 7.292 * 10^(-5);
% convert t to seconds
t = t * 60;

[r, c] = size(inputM);
%update the inputM.
for i = 1 : r
    for j = 1 : c
        inputM(r, c) = wrapTo2Pi( inputM(r, c) + w_E * t );
    end
end

end

