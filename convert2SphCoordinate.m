function sphCoor = convert2SphCoordinate(an_orbit, angle)
%convert2SphCoordinate
%   input the parameters of the orbit and the γ angle that describes
%   satellite position. The function transforms these parameters to the
%   spherical coordinate of the satellite as the output( 1 * 3 vector).
%   : [radialDistance polarAngle AzimuthalAngle], both in radian

%   an_orbit : one entry of the struct array(storing orbit parameters).
%   angle : the γ angle rotated in the plane.
%   wrapTo2Pi function : wrap an angle in radian to [0, 2pi]
global r;
p = an_orbit.polar;
az = an_orbit.azim;

sphCoor(1) = an_orbit.height + r;                 % radial distance
sphCoor(2) = pi/2 - acos( sin(p) * cos(angle) );  % elevation angle
if p == 0
    sphCoor(3) = wrapTo2Pi(az + pi + angle); % azimuthal angle
elseif (sin(p)^2) * (cos(angle)^2) == 1                        % satellite may be on the z-axis, 
    sphCoor(3) = 0;                                            % azimuthal angle is not defined. assign 0 to sphcoor(3).
elseif (angle >= 3*pi/2 && angle <= 2 * pi) || (angle >= 0 && angle <= pi/2)
    temp = acos( sin(angle) / sqrt(1 - (sin(p)^2) * (cos(angle)^2) ) );
    sphCoor(3) = wrapTo2Pi(az + pi/2 + temp);
elseif (angle > pi/2 && angle < 3*pi/2)
    temp = 2 * pi - acos( sin(angle) / sqrt(1 - (sin(p)^2) * (cos(angle)^2) ) );
    sphCoor(3) = wrapTo2Pi(az + pi/2 + temp);
end

end
