function drawOrbit(orbits,num_of_orbit)
%DRAWORBIT 此处显示有关此函数的摘要
%   此处显示详细说明
for i = 1 : num_of_orbit
    r = orbits(i).height + 6371;
    normalVector = [cos(orbits(i).polar) * sin(orbits(i).azim) sin(orbits(i).azim) * sin(orbits(i).polar) cos(orbits(i).polar)];
    c = [0 0 0];
    theta = (0:2 * pi / 100 : 2 * pi);
    a = cross(normalVector,[1 0 0]);
    if ~any(a)
      a = cross(normalVector,[0 1 0]);
    end
    b = cross(normalVector,a);
    a = a / norm(a);
    b = b / norm(b);

    c1=c(1)*ones(size(theta,1),1);
    c2=c(2)*ones(size(theta,1),1);
    c3=c(3)*ones(size(theta,1),1);

    x=c1+r*a(1)*cos(theta)+r*b(1)*sin(theta);%圆上各点的x坐标
    y=c2+r*a(2)*cos(theta)+r*b(2)*sin(theta);%圆上各点的y坐标
    z=c3+r*a(3)*cos(theta)+r*b(3)*sin(theta);%圆上各点的z坐标

    plot3(x,y,z)
end
end

