global iLa iLong oLa oLong t;
global r;   
r = 6371;           %earth radius
global d_max;       % max communicating distance between two satellites
global orbitR;      % orbit radius
global pathVector;  % vector storing numbers of satellites in the shortest path

hold on

% =====================================
%Temporarily settings for testing. parameter values 
%can be modified in the future
orbitHeight = 550;
num_of_satellites_each = 30;
input_polar = [pi/2 5*pi/12 pi/4];
input_azim = linspace(0, 11*pi/6, 12); 
num_of_orbit = length(input_azim) * length(input_polar);

d_max = 2 * sqrt(orbitHeight^2 + 2 * r * orbitHeight);
orbitR = r + orbitHeight;

TIME = 0;
counter = 0;

% ====================================
% build the structure
orbits = constructOrbits(orbitHeight, num_of_satellites_each,input_polar,input_azim);
satellite_positions = initializeSatellitePositions(num_of_orbit, num_of_satellites_each);

% ====================================
%construct the adjacency matrix of the network graph
networkGraph = constructNetworkBrute(orbits, satellite_positions);