function varargout = GUI(varargin)
% GUI M-file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 28-Dec-2016 20:20:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function GxVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function WidthVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WidthVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function T2Val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2Val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function TRVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TRVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function dTVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dTVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulateButton.
function simulateButton_Callback(hObject, eventdata, handles)
% hObject    handle to simulateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Get The Values of different parameters from line edit widgets
protons = [1 0 0]';
objectWidth = str2double(get(handles.WidthVal,'String'))*10^-3;
Rx = str2double(get(handles.RxVal,'String'))*10^-3;
protons = repmat(protons,1,round(objectWidth/Rx));
Gx = str2double(get(handles.GxVal,'String'))*10^-3; %T/m
tau = str2double(get(handles.TRVal,'String'))*10^-3;%sec
Accumulate = get(handles.PAVal,'value');
dt = str2double(get(handles.dTVal,'String'))*10^-3; %sec
gamma = 2*pi*42.58*10^6; %Hz/T

%% Get dt if not provided equation 5.77
if dt == 0    
    dt = 2*pi/(Gx*gamma*objectWidth);
    set(handles.dTVal,'String',dt*10^3);
end
%% Get tau if not provided equation 5.87
if tau == 0 
    tau = 2*pi/(Gx*gamma*Rx);
    set(handles.TRVal,'String',tau*10^3);    
    return;
end
T2 = str2double(get(handles.T2Val,'String'))*10^-3; %sec
[signalFFT, t] = getSignal(protons, Gx, objectWidth,Rx, tau, Accumulate, T2,dt);

%% Plot the sampled k-space 
axes(handles.signalFig);
plot(t,real(signalFFT),'b','linewidth',1.5);
xlabel('Time (sec)');
ylabel('Mangnitude');
grid on;

%% Plot Reconstructed Signal from sampled k-space
signal = fftshift(ifft(signalFFT));
len = length(t);
FOVx = 2*pi/(Gx*gamma*dt);
x = [-FOVx/2+FOVx/len:FOVx/len:FOVx/2]*(10^3);
axes(handles.objectFig);
plot(x, abs(signal),'b','linewidth',1.5);
axis([min(x)-2 max(x)+2 0 max(abs(signal))*1.2]);
xlabel('X (mm)');
ylabel('Magnitude');
grid on;

% --- Executes on button press in PAVal.
function PAVal_Callback(hObject, eventdata, handles)
% hObject    handle to PAVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PAVal



function TRVal_Callback(hObject, eventdata, handles)
% hObject    handle to TRVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TRVal as text
%        str2double(get(hObject,'String')) returns contents of TRVal as a double



function dTVal_Callback(hObject, eventdata, handles)
% hObject    handle to dTVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dTVal as text
%        str2double(get(hObject,'String')) returns contents of dTVal as a double



function WidthVal_Callback(hObject, eventdata, handles)
% hObject    handle to WidthVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of WidthVal as text
%        str2double(get(hObject,'String')) returns contents of WidthVal as a double



function GxVal_Callback(hObject, eventdata, handles)
% hObject    handle to GxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GxVal as text
%        str2double(get(hObject,'String')) returns contents of GxVal as a double



function T2Val_Callback(hObject, eventdata, handles)
% hObject    handle to T2Val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2Val as text
%        str2double(get(hObject,'String')) returns contents of T2Val as a double


% --- Executes on mouse press over axes background.
function signalFig_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to signalFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function objectFig_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to objectFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on simulateButton and none of its controls.
function simulateButton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to simulateButton (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function RxVal_Callback(hObject, eventdata, handles)
% hObject    handle to RxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RxVal as text
%        str2double(get(hObject,'String')) returns contents of RxVal as a double


% --- Executes during object creation, after setting all properties.
function RxVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to GxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of GxVal as text
%        str2double(get(hObject,'String')) returns contents of GxVal as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.TRVal,'String',0);
set(handles.dTVal,'String',0);
simulateButton_Callback(hObject,eventdata,handles);
