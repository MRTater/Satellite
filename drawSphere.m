
function s = drawSphere(r, centerx, centery, centerz, N)
load topo;
if nargin == 5
 [x,y,z] = sphere(N);
else
 [x,y,z] = sphere(50);
end
s = surface(r*x+centerx, r*y+centery, r*z+centerz,'FaceColor','texturemap','CData',topo);
view(90,50);
 colormap(topomap1);
% Brighten the colormap for better annotation visibility:
 brighten(.6)
% Create and arrange the camera and lighting for better visibility:
campos('auto');
 camlight;
 lighting gouraud;
axis off vis3d;
% surf(r*x+centerx, r*y+centery, r*z+centerz);


