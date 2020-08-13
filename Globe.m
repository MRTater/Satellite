%==========================================================================
%draw the earth
%==========================================================================

cla reset;
% global r;           % earth radius
r = 6371;
drawUI;
hold on

%==========================================================================
%import data, build the structure that storing orbit and satellite data
%==========================================================================

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

%==========================================================================
%construct the adjacency matrix of the network graph, find the shortest path
%==========================================================================

%A, B;==============================
global pathVector;
pathVector = [ ];


%==========================================================================
% draw all orbits, satellites along the shortest path and two ground points
%==========================================================================

drawOrbit(orbits,num_of_orbit);

