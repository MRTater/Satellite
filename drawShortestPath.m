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
    if b == 0
        b = num_of_satellites_each;
    end
    
    temp = convert2SphCoordinate(orbitM(a), satelliteM(a, b));
    sphInf(i).index(1) = a;
    sphInf(i).index(2) = b;
    [sphInf(i).x, sphInf(i).y, sphInf(i).z] = sph2cart(temp(3) + pi, temp(2), temp(1));
end

% draw satellites
for i = 1 : N
    figure_s = plot3(sphInf(i).x, sphInf(i).y, sphInf(i).z, '*', ...
                                              'Color','#A2142F', ...
                                                 'LineWidth', 1, ...
                                                 'MarkerSize', 9);
                                             
                                             
    set(figure_s, 'HandleVisibility', 'off');
    
    
    
    
end

% draw the path 
for i = 1 : N - 1
    X = [sphInf(i).x sphInf(i+1).x]; 
    Y = [sphInf(i).y sphInf(i+1).y];
    Z = [sphInf(i).z sphInf(i+1).z];
    figure_line = line(X,Y,Z, 'Color', 'red', ...
                            'LineWidth', 0.8   );
                        
                        
    set(figure_line, 'HandleVisibility', 'off');   
    
    
    
end
view(3);

% print indexes of all satellites (pair of number[i, j])
for i = 1 : N
    print = ['satellite ', num2str(i), ' : [', ...
             num2str(sphInf(i).index(1)), ' ', ...
             num2str(sphInf(i).index(2)), ']'];
    disp(print)
end

end

