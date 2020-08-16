%==========================================================================
%draw the earth
%==========================================================================

cla reset;
global r;           % earth radius
r = 6371;
hold on

%==========================================================================
%import data, build the structure that storing orbit and satellite data
%==========================================================================

%Temporarily settings for testing. parameter values 
%can be modified in the future
orbitHeight = 550;
num_of_satellites_each = 30;
input_polar = [pi/2 5*pi/12 pi/4];
input_azim = linspace(0, 11*pi/6, 12); 
num_of_orbit = length(input_azim) * length(input_polar);

global d_max;       % max communicating distance between two satellites
d_max = 2 * sqrt(orbitHeight^2 + 2 * r * orbitHeight);  
global orbitR;      % orbit radius
orbitR = r + orbitHeight;

global pathVector;  % vector storing numbers of satellites in the shortest path

TIME = 0;
counter = 0;

% ====================================
% build the structure
orbits = constructOrbits(orbitHeight, num_of_satellites_each,input_polar,input_azim);
satellite_positions = initializeSatellitePositions(num_of_orbit, num_of_satellites_each);

% ====================================
%construct the adjacency matrix of the network graph
networkGraph = constructNetworkBrute(orbits, satellite_positions);

O.longitude = 0;                 % origin ground point
O.latitude = 0;
D.longitude = 120;               % destination ground point 
D.latitude = 0;

[s(1), s(2)] = ground2Satellites(O, orbits, satellite_positions); % the starting satellite
[e(1), e(2)] = ground2Satellites(D, orbits, satellite_positions); % the ending satellite
pathVector = [];
PathFindingFloyd(networkGraph, num_of_satellites_each, s, e);

