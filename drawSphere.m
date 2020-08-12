
function s = drawSphere()
if nargin == 0
    load topo.mat topo topomap1;
    [x,y,z] = sphere(24);
    s = surface(x, y, z,'FaceColor','texture','CData',topo);
    view(-90,25);
    colormap(topomap1);
    % Brighten the colormap for better annotation visibility:
    brighten(.6)
    % Create and arrange the camera and lighting for better visibility:
    campos('auto');
    camlight;
    lighting gouraud;
    set(gca, ...
          'NextPlot','add', ...
          'Visible','off');
    axis equal
    set(get(gca,'Title'),'Visible','on')
    % surf(r*x+centerx, r*y+centery, r*z+centerz);
end

