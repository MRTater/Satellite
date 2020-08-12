%==========================================================================
%draw the earth

cla reset;
load topo;
global r;           % earth radius
r = 6371;
s = drawSphere(r, 0, 0, 0);
hold on;

%==========================================================================
%build the structure that storing orbit data and satellite data

%Temporarily settings for testing. Values of the parameter can be modified later
orbitHeight = 550;
num_of_orbit = 5;
num_of_satellites_each = 30;
input_polar_angle = [0 pi/6 pi/4 pi/3 pi/2];
input_azimuthal_angle = 0; 

global d_max;       % max communicating distance between two satellites
d_max = 2 * sqrt(orbitHeight^2 + 2 * r * orbitHeight);  
global orbitR;      % orbit radius
orbitR = r + orbitHeight;

% build the structure
orbits = constructOrbits(orbitHeight,num_of_orbit,num_of_satellites_each,input_polar_angle,input_azimuthal_angle);
satellite_positions = initializeSatellitePositions(num_of_orbit, num_of_satellites_each);

% draw all satellite orbits
drawOrbit(orbits,num_of_orbit);


