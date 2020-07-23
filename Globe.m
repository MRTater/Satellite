cla reset;
load topo;
r = 6371;
s = drawSphere(6371,0,0,0);
% data-structre-storing-the-data
% random thing for only test use

%% build the structure that storing orbit data and satellite data
%   写道一半想到其实可以写成函数 下次再说
%Temporarily settings for testing. Values of the parameter can be modified later
orbitHeight = 550;
num_of_orbit = 5;
num_of_satellites_each = 30;
input_polar_angle = [0 pi/6 pi/4 pi/3 pi/2];
input_azimuthal_angle = 0;

orbits = constructOrbits(orbitHeight,num_of_orbit,num_of_satellites_each,input_polar_angle,input_azimuthal_angle)


%%