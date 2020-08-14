function inputM = updateOrbitPositions(inputM, t)
%updateOrbitPositions Function that realizes dynamic.
%   calculate and update the relative motion of satellite orbits
%   with respect to the earth caused by the rotation of the earth
%
%   inputM : matrix that stores parameters of all orbits
%   t: update time interval measured in minutes

% the angular speed of earth rotation, in radian
w_E = 7.2921 * 10^(-5);

% convert t to seconds
t = t * 60;

N = length(inputM);
% update the inputM.
for i = 1 : N
    inputM(i).azim = wrapTo2Pi( inputM(i).azim - w_E * t);
end

end