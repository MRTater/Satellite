function drawOrbit(orbits)
%This function draws all satellite orbits in the same figure of the earth
%first we derive the parameter  function of the circle, then use plot3 function.

global orbitR % orbit radius
num_of_orbit = length(orbits);

for i = 1 : num_of_orbit
    normalVector = [sin(orbits(i).polar)*cos(orbits(i).azim) sin(orbits(i).azim)*sin(orbits(i).polar) cos(orbits(i).polar)];
    c = [0 0 0];
    theta = (0 : 2 * pi / 100 : 2 * pi); % parameter
    a = cross(normalVector,[1 0 0]);
    if ~any(a)
      a = cross(normalVector,[0 1 0]);
    end
    b = cross(normalVector,a);
    a = a / norm(a);
    b = b / norm(b);

    c1 = c(1) * ones(size(theta,1),1);
    c2 = c(2) * ones(size(theta,1),1);
    c3 = c(3) * ones(size(theta,1),1);

    x = c1 + orbitR * a(1) * cos(theta) + orbitR * b(1) * sin(theta);%  x coordinate in the circle
    y = c2 + orbitR * a(2) * cos(theta) + orbitR * b(2) * sin(theta);%  y coordinate in the circle
    z = c3 + orbitR * a(3) * cos(theta) + orbitR * b(3) * sin(theta);%  z coordinate in the circle
    
    plot3(x,y,z, 'Color', '#EDB120','LineWidth', 0.1);
end

end

