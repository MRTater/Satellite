function drawUI(action)
global iLa iLong oLa oLong t;
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
%    callbackStr = 'drawUI(''Latitude'');';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr);
   La1 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
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
      'String',labelStr);
   Long1 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
       'CallBack',@inputLong);
   % ====================================
   % The Destination Latitude output button
   btnNumber = 4;
   yPos = top-btnHt-(btnNumber-1)*(btnHt+spacing);
   labelStr = 'Destination Longtitude';
   
   % Generic button information
   btnPos1 = [left yPos-spacing+btnHt/2 btnWid btnHt/2];
   btnPos2 = [left yPos-spacing btnWid btnHt/2];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',btnPos1, ...
      'String',labelStr);
   La2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
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
      'String',labelStr);
   Long2 = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
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
      'String',labelStr);
   T = uicontrol(...
       'Style','edit',...
       'Units','normalized',...
       'Position',btnPos2,...
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
      'Callback',callbackStr);
   
   % Uncover the figure
   % Now run the demo. With no arguments, "wrldtrv2" just draws the globe
    drawSphere(6371);
    watchoff(oldFigNumber);
    figure(figNumber);

elseif strcmp(action,'Computation')
   % ====================================
   
   % ====== Start of Demo
   
   % ====== End of Demo
else
    inputLa;
    inputLong;
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
