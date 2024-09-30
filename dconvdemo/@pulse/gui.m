function gui(varargin)
%GUI Create and manage the graphic controls for PULSE object
%   GUI(Signal, Pos) creates the controls in the rectangle of the current
%   figure described by Pos to let the user interactively change the PULSE
%   object's parameters.  Pos is in normalized units.
%
%   GUI(Signal) assumes the position rectangle of [0 0 1 1]
%
%   This function assumes a figure has already been created and that its
%   UserData property holds a PULSE object.
%
%   The function was written to be use within the SIGGENDLG function.
%
%   Callbacks:
%     GUI('Replot') replots the Signal data with the current parameters and
%     stores the PULSE data in the UserData property of the plot.
%
%     GUI('Rescale Plot') rescales the x and y axis of the plot to fit the data.
%
%   See also SIGGENDLG, PULSE

% Jordan Rosenthal, 12/16/97

% Rev 1 - 11/10/02 - Rajbabu Velmurugan,
%                   Updated to handle changes to 'stem' in ML6.5
%                   Matlab function, 'stem' returns handles to 3 objects
% Rev 2 - 03/06/09 - Greg Krudysz,
%                   Updated to handle 'stem' plots using 'stemdata' methods
%                   Matlab function, 'stem' returns handles to 3 objects as in ML version 6.
% Rev 3 - 06/02/09 - Greg Krudysz,
%                   Rewrote redundant code into 'stemdata' method to fix
%                   baseline bug in 'Replot'
switch nargin
    case 1
        action = 'Initialize';
        Signal = varargin{1};
        Pos = [0 0 1 1];
    case 2
        Signal = varargin{1};
        if ~isstr(varargin{2})
            action = 'Initialize';
            Pos = varargin{2};
        else
            action = varargin{2};
        end
    otherwise
        error('Illegal action.');
end

switch action
    case 'Rescale Plot'
        Handles = getappdata(gcbf,'Handles');
        rescaleplot(Signal,Handles.PlotAxis);
    case 'Replot'
        Handles = getappdata(gcbf,'Handles');
        Values = get(Handles.Controls,'Value');
        Signal = pulse( ...
            'Name',Signal.Name, ...
            'Amplitude',Values{1}, ...
            'Length',Values{2}, ...
            'Delay',Values{3} );
        set(gcbf,'UserData',Signal);
        %hStemMarkers = findobj(Handles.PlotLines,'Marker','o');
        hStemMarkers = Handles.PlotLines(1);
        %hStemLines = findobj(Handles.PlotLines,'Marker','none');
        hStemLines = Handles.PlotLines(2);
        if size(Handles.PlotLines,1) > 2
            hBaseLine  = Handles.PlotLines(3);
        end
        
        Handles.PlotLines = stemdata(Signal,Handles.PlotLines);
        set( get(Handles.PlotAxis, 'title'), 'String',formulastring(Signal));
    case 'Initialize'
        %%%  Create Plot  %%%
        Plot_Pos  = [0.06*Pos(3)+Pos(1) 0.2*Pos(4)+Pos(2) 0.5*Pos(3) 0.7*Pos(4)];
        hLines = stemdata(Signal);
        hAxes = gca;
        set(gca, 'Position', Plot_Pos, 'Box', 'on', ...
            'ButtonDownFcn','gui(get(gcbf,''UserData''),''Rescale Plot'')');
        
        %%% Create rescale text message  %%%
        Text_Pos = [0.06*Pos(3)+Pos(1) 0.05*Pos(4)+Pos(2) 0.5*Pos(3) 0.05*Pos(4)];
        uicontrol('Units','normalized', ...
            'BackgroundColor',get(0,'DefaultFigureColor'), ...
            'ForegroundColor','r', ...
            'FontUnits','normalized', ...
            'Position',Text_Pos, ...
            'String','Click inside plot area to rescale axis', ...
            'Style','text');
        
        %%%  Create Controls  %%%
        Controls_Pos = [0.6*Pos(3)+Pos(1) 0.2*Pos(4)+Pos(2) 0.38*Pos(3) 0.7*Pos(4)];
        
        nParams = 3;
        Parameters = {'Amplitude','Length','Delay'};
        Labels = {'Amplitude:','Length:','Delay:'};
        Values = num2str( ...
            [Signal.Amplitude; ...
            Signal.Length; ...
            Signal.Delay] );
        Min = [-Inf; 1; -Inf];
        Max = [Inf; Inf; Inf];
        
        Width = 0.1*ones(1,nParams);
        Height = 0.05*ones(1,nParams);
        Left = ( Controls_Pos(1) + Controls_Pos(3) - Width ) - 0.1;
        Bottom = Controls_Pos(2) + Controls_Pos(4)-Controls_Pos(4)/nParams*[0:nParams-1] - Height;
        NumEditPos = [Left; Bottom; Width; Height];
        LabelWidth = 0.15*ones(1,nParams);
        LabelHeight = Height;
        LabelLeft = Left - 0.16;
        LabelBottom = Bottom - 0.005;
        LabelPos = [LabelLeft; LabelBottom; LabelWidth; LabelHeight];
        DefFigColor = get(0,'DefaultFigureColor');
        h = zeros(nParams,1);
        for i = 1:nParams
            uicontrol('Units','Normalized', ...
                'Position',LabelPos(:,i), ...
                'BackgroundColor',DefFigColor, ...
                'FontUnits','normalized', ...
                'FontWeight','Bold', ...
                'HorizontalAlignment','right', ...
                'String',Labels{i}, ...
                'style','text');
            h(i) = uinumedit('Units','normalized', ...
                'BackgroundColor','w', ...
                'CallBack','gui(get(gcbf,''UserData''),''Replot'')', ...
                'Min', Min(i), ...
                'Max', Max(i), ...
                'Position',NumEditPos(:,i), ...
                'String',Values(i,:), ...
                'Tag',Labels{i});
        end
        
        % Store handles for use in callbacks
        Handles.Controls = h;
        Handles.PlotAxis = hAxes;
        Handles.PlotLines = hLines;
        setappdata(gcf, 'Handles', Handles);
        rescaleplot(Signal,Handles.PlotAxis);
    otherwise
        error('Illegal action.');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  rescaleplot(Signal,hPlotAxis)  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rescaleplot(Signal,hPlotAxis)
XLim = [min(Signal.XData)-2 max(Signal.XData)+2];
YLim = [min(0,1.5*min(Signal.YData)) max(0,1.5*max(Signal.YData))];
if XLim(1) == XLim(2)
    XLim(1) = XLim(1) - 1;
    XLim(2) = XLim(2) + 1;
end
if YLim(1) == YLim(2)
    YLim = [0 1];
end
set(hPlotAxis,'XLim',XLim,'YLim',YLim);
