function drawUI(action)

global iLa iLong oLa oLong t;
global r;   r = 6371;   %earth radius
global d_max;       % max communicating distance between two satellites
global orbitR;      % orbit radius
global pathVector;  % vector storing numbers of satellites in the shortest path
global TIME;        % time passed in the model, measured from the initialization
global counter;     % counts # of mouse clicking 'computation'

hold on

old_format = get(0,'Format');
if nargin < 1
   action = 'initialize';
end

% =====================================
%declare variables
%Temporarily settings for testing. parameter values 
%can be modified in the future
orbitHeight = 550;
num_of_satellites_each = 30;
input_polar = [pi/2 5*pi/12 pi/4];
input_azim = linspace(0, 11*pi/6, 12); 
num_of_orbit = length(input_azim) * length(input_polar);

d_max = 2 * sqrt(orbitHeight^2 + 2 * r * orbitHeight);
orbitR = r + orbitHeight;

if strcmp(action,'initialize')
   oldFigNumber = watchon;
   figNumber = figure( ...
      'Name','Satellite Network', ...
      'NumberTitle','off', ...
      'Visible','off');
   axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.03 0.60 0.90], ...
      'Visible','on', ...
      'NextPlot','add',...
      'HandleVisibility', 'on');
   
   % ===================================
   % Information for all buttons
   top = 0.95;
   bottom = 0.05;
   labelColor = [0.8 0.8 0.8];
   yInitPos = 0.90;
   left = 0.70;
   btnWid = 0.25;
   btnHt = 0.10;
   % Spacing between the button and the next command's label
   spacing = 0.02;
   
   % ====================================
   % The CONSOLE frame
   frmBorder = 0.02;
   frmPos = [left-frmBorder bottom-frmBorder btnWid+2*frmBorder 0.9+2*frmBorder];
   h = uicontrol( ...
      'Style','frame', ...
      'Units','normalized', ...
      'Position',frmPos, ...
      'BackgroundColor',[0.5 0.5 0.5], ...
      'HandleVisibility', 'off');
   
   % ====================================
   % The Computation button
   btnNumber = 1;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Computation';
   cmdStr = 'Computation';
   callbackStr = 'drawUI(''Computation'');';
   
   % Generic button information
   btnPos = [left yPos-spacing btnWid btnHt];
   flyHndl = uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'HandleVisibility', 'off');
   
   % ====================================
   % The ORIGIN Latitude input button
   btnNumber = 2;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Origin Latitude';
   cmdStr = 'Latitude';
%    callbackStr = 'drawUI(''Latitude'');';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr, ...
      'HandleVisibility', 'off');
   La1 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'HandleVisibility', 'off', ...
       'CallBack',@inputLa);

   % ====================================
   % The ORIGIN Longtitude input button
   btnNumber = 3;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Origin Longtitude';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr, ...
      'HandleVisibility', 'off');
   Long1 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'HandleVisibility', 'off', ...
       'CallBack',@inputLong);
   % ====================================
   % The Destination Latitude output button
   btnNumber = 4;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Destination Latitude';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr, ...
      'HandleVisibility', 'off');
   La2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'HandleVisibility', 'off', ...
       'CallBack',@outputLa);
   % ====================================
   % The Destination Longtitude output button
   btnNumber = 5;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Destination Longtitude';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr, ...
      'HandleVisibility', 'off');
   Long2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'HandleVisibility', 'off', ...
       'CallBack',@outputLong);
    % ====================================
   % The time input button
   btnNumber = 6;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Time';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr, ...
      'HandleVisibility', 'off');
   T = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'HandleVisibility', 'off', ...
       'CallBack',@time);
   % ====================================    
   % The CLOSE button
   labelStr = getString(message('MATLAB:demos:shared:LabelClose'));
   callbackStr = 'close(gcf)';
   uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[left bottom btnWid btnHt], ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'HandleVisibility', 'off');
  
   % =====================================
   % initialization
   TIME = 0;
   counter = 0;
   
   % Uncover the figure
   % With no arguments, the program just draws the globe and all orbits.
   drawSphere(6371);
   watchoff(oldFigNumber);
   figure(figNumber);
   
   % draw all satellite orbits 
   orbits = constructOrbits(orbitHeight, num_of_satellites_each,input_polar,input_azim);
   drawOrbit(orbits);
   
elseif strcmp(action,'Computation')
   % ====== Start of Demo
   % The 'Computation' botton must be clicked after all inputs being
   % assigned valid values. 
   % =====================================
   % load positions of ground points.
   clf;
   axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.03 0.60 0.90], ...
      'Visible','on', ...
      'NextPlot','add',...
      'HandleVisibility', 'on');
   O.longitude = iLong;                 % origin ground point
   O.latitude =  iLa;
   D.longitude = oLong;                 % destination ground point 
   D.latitude = oLa;
   
   %======================================
   % first time clicking the botton, the program shows the figure in t=0
   % dynamic network will be shown from the twice click.
   
   % initialize and update the data
   TIME
   counter
   orbits = constructOrbits(orbitHeight, num_of_satellites_each,input_polar,input_azim);
   orbits = updateOrbitPositions(orbits, TIME);
   satellite_positions = initializeSatellitePositions(num_of_orbit, num_of_satellites_each);
   satellite_positions = updateSatellitePositions(satellite_positions, TIME);
   % update the networkgraph matrix
   networkGraph = constructNetworkBrute(orbits, satellite_positions);
   TIME = TIME + t;
   %======================================
   % find the start and end satellites,
   % find the shortest path and store it in 'pathVector'.
   [s(1), s(2)] = ground2Satellites(O, orbits, satellite_positions); % the starting satellite
   [e(1), e(2)] = ground2Satellites(D, orbits, satellite_positions); % the ending satellite
   pathVector = [];
   PathFindingFloyd(networkGraph, num_of_satellites_each, s, e);
   
   %======================================
   % draw all figures
   drawSphere(6371);
   orbitgraph = drawOrbit(orbits);
   source = drawGroundPoints(O); 
   sink = drawGroundPoints(D);
   path = drawShortestPath(orbits, satellite_positions);
   % ====== End of Demo
   counter = counter + 1;
%    delete([orbitgraph source sink]);
end    % if strcmp(action, ...

%  Restore Format
set(0,'Format',old_format)

function inputLa(~,~)
    str = get(La1,'String');
    iLa = str2double(str);
    end
function outputLa(~,~)
    str = get(La2,'String');
    oLa = str2double(str);
end
function inputLong(~,~)
    str = get(Long1,'String');
    iLong = str2double(str);
end
function outputLong(~,~)
    str = get(Long2,'String');
    oLong = str2double(str);
end
function time(~,~)
    str = get(T,'String');
    t = str2double(str);
end

end
