function drawShortestPath(orbitM, satelliteM)
%drawShortestPath : draw the shortest path and all satellites along 
%                   the path.
%
%
global pathVector;

[~, num_of_satellites_each] = size(satelliteM);

% before draw the path and satellites, need to calculate satellites'
% cartesian coordinate.

%get the size
[~, N] = size(pathVector);
% sphInf : stores cartesian coordinate of satellites and their numbers.
sphInf = repmat( struct('index', [0,0], ...    % index = [i j] means this satellite is the j th on the i th orbit.
                         'x', 0,        ...
                         'y', 0,        ...
                         'z', 0     ), 1, N);
for i = 1 : N
    a = ceil(pathVector(i) / num_of_satellites_each);
    b = mod(pathVector(i), num_of_satellites_each); 
    temp = convert2SphCoordinate(orbitM(a), satelliteM(a, b));
    sphInf(i).index(1) = a;
    sphInf(i).index(2) = b;
    [sphInf(i).x, sphInf(i).y, sphInf(i).z] = sph2cart(temp(3), temp(2), temp(1));
end

% draw satellites
for i = 1 : N
    plot3(sphInf(i).x, sphInf(i).y, sphInf(i).z, '*', ...
                                   'Color','#A2142F', ...
                                   'LineWidth', 1, ...
                                   'MarkerSize', 9)
end
% draw the path 
for i = 1 : N - 1
    X = [sphInf(i).x sphInf(i+1).x]; 
    Y = [sphInf(i).y sphInf(i+1).y];
    Z = [sphInf(i).z sphInf(i+1).z];
    line(X,Y,Z, 'Color', 'red', ...
                'LineWidth', 0.8   );
end
view(3);

end

