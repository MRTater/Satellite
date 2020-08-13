function drawUI(action)
old_format = get(0,'Format');
if nargin < 1
   action = 'initialize';
end

if strcmp(action,'initialize')
   oldFigNumber = watchon;
   figNumber = figure( ...
      'Name','Satellite Network', ...
      'NumberTitle','off', ...
      'Visible','off');
   axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.03 0.60 0.90], ...
      'Visible','off', ...
      'NextPlot','add');
   
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
      'BackgroundColor',[0.5 0.5 0.5]);
   
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
      'Callback',callbackStr);
   
   % ====================================
   % The ORIGIN Latitude input button
   btnNumber = 2;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Origin Latitude';
   cmdStr = 'Latitude';
   callbackStr = 'drawUI(''Latitude'');';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   La1 = uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr);
   La2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'CallBack',callbackStr);
   % ====================================
   % The ORIGIN Longtitude input button
   btnNumber = 3;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Origin Longtitude';
   cmdStr = 'Longtitude';
   callbackStr = 'wrldtrv(''Longtitude'');';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   Long1 = uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr);
   Long2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'CallBack',callbackStr);
   % ====================================
   % The WESTERN HEMISPHERE radio button
   btnNumber = 4;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = getString(message('MATLAB:demos:wrldtrv:LabelWHemisphere'));
   callbackStr = 'drawUI(''hemisphere'');';
   
   % Generic button information
   btnPos = [left yPos-spacing btnWid btnHt];
   westHndl = uicontrol( ...
      'Style','radiobutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Value',1, ...
      'Callback',callbackStr);
   
   % ====================================
   % The EASTERN HEMISPHERE radio button
   btnNumber = 5;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = getString(message('MATLAB:demos:wrldtrv:LabelEHemisphere'));
   callbackStr = 'drawUI(''hemisphere'');';
   
   % Generic button information
   btnPos = [left yPos-spacing btnWid btnHt];
   eastHndl = uicontrol( ...
      'Style','radiobutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Value',0, ...
      'Callback',callbackStr);
   
   % ====================================
   % ====================================
   % The CLOSE button
   labelStr = getString(message('MATLAB:demos:shared:LabelClose'));
   callbackStr = 'close(gcf)';
   closeHndl = uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[left bottom btnWid btnHt], ...
      'String',labelStr, ...
      'Callback',callbackStr);
   
   % Uncover the figure
   % Now run the demo. With no arguments, "wrldtrv2" just draws the globe
   drawSphere(6371);
   
   watchoff(oldFigNumber);
   figure(figNumber);
   
elseif strcmp(action,'fly'),
   % ====================================
   
   
   % ====== Start of Demo
   % Wrldtrv problem
   drawSphere(6371);
   
   % ====== End of Demo
   watchoff(figNumber);
elseif strcmp(action,'Latitude'),
    
elseif strcmp(action,'Longtitude'), 
    
elseif strcmp(action,'hemisphere'),
   axHndl = gca;
   figNumber = watchon;
   drawnow;
   hndlList = get(figNumber,'Userdata');
   popupHndl1 = hndlList(1);
   popupHndl2 = hndlList(2);
   westHndl = hndlList(3);
   eastHndl = hndlList(4);
   if gco == westHndl,
      view(-90,25);
      set(westHndl,'Value',1);
      set(eastHndl,'Value',0);
      popupStr = str2mat('Cape Town','Dakar','London','Miami','Moscow', ...
         'Nairobi','Natick','New Delhi','Riyadh','Sao Paulo');
      latLongData = [-34 18.3; 14.5 -17.5; 51.5 0; 25.7 -80; 55.7 37.5; ...
         1.3 36.8; 42.3 -71.4; 28.5 77.1; 24.5 46.6; -23.5 -46.5];
      set(popupHndl1,'String',popupStr,'UserData',latLongData);
      set(popupHndl2,'String',popupStr,'UserData',latLongData,'Value',10);
   else
      view(90,25);
      set(westHndl,'Value',0);
      set(eastHndl,'Value',1);
      popupStr = str2mat('Anchorage','Beijing','Guam','Honolulu','Natick', ...
         'San Diego','Singapore','Sydney','Tokyo','Wellington');
      latLongData = [61.2 -150; 40 116.4; 13.5 144.8; 21.3 -157.9; 42.3 -71.4; ...
         32.6 -117.2; 1.3 103.9; -33.9 151.2; 35.6 139.7; -41.3 174.8];
      set(popupHndl1,'String',popupStr,'UserData',latLongData);
      set(popupHndl2,'String',popupStr,'UserData',latLongData,'Value',10);
   end;
   watchoff(figNumber);
   
   
end;    % if strcmp(action, ...

%  Restore Format
set(0,'Format',old_format)

