
function s = drawSphere(r)
if nargin == 1
    load topo.mat topo topomap1;
    [x,y,z] = sphere(24);
    s = surface(x*r, y*r, z*r,'FaceColor','texture','CData',topo);
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
%     axis on
    set(get(gca,'Title'),'Visible','on')
    % surf(r*x+centerx, r*y+centery, r*z+centerz);
end

