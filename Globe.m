%==========================================================================
%draw the earth
%==========================================================================

cla reset;
global r;           % earth radius
r = 6371;
drawUI;
hold on

%==========================================================================
%import data, build the structure that storing orbit and satellite data
%==========================================================================

%Temporarily settings for testing. parameter values 
%can be modified in the future
orbitHeight = 550;
num_of_satellites_each = 20;
input_polar = [0 pi/12 pi/6 pi/4 pi/3 5*pi/12 17*pi/36];
input_azim = linspace(0, 11*pi/12, 12); 
num_of_orbit = length(input_azim) * length(input_polar);

global d_max;       % max communicating distance between two satellites
d_max = 2 * sqrt(orbitHeight^2 + 2 * r * orbitHeight);  
global orbitR;      % orbit radius
orbitR = r + orbitHeight;

% build the structure
orbits = constructOrbits(orbitHeight, num_of_satellites_each,input_polar,input_azim);
satellite_positions = initializeSatellitePositions(num_of_orbit, num_of_satellites_each);

%==========================================================================
%construct the adjacency matrix of the network graph, find the shortest path
%==========================================================================

%A, B;==============================
global pathVector;
pathVector = [ ];


%==========================================================================
% draw all orbits, the shortest path, all satellites along the path
% and two ground points.
%==========================================================================

drawOrbit(orbits);



