function varargout = simulator(varargin)
% SIMULATOR MATLAB code for simulator.fig
%      SIMULATOR, by itself, creates a new SIMULATOR or raises the existing
%      singleton*.
%
%      H = SIMULATOR returns the handle to a new SIMULATOR or the handle to
%      the existing singleton*.
%
%      SIMULATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATOR.M with the given input arguments.
%
%      SIMULATOR('Property','Value',...) creates a new SIMULATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simulator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simulator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simulator

% Last Modified by GUIDE v2.5 10-Dec-2018 17:30:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simulator_OpeningFcn, ...
                   'gui_OutputFcn',  @simulator_OutputFcn, ...
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


% --- Executes just before simulator is made visible.
function simulator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simulator (see VARARGIN)

% Choose default command line output for simulator
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% load pop-up menu data
global gravities surfaces vehicles;
load('data.mat');

gravitiesNames = [table2array(gravities(:,'name')); "Custom"];
surfacesNames = [table2array(surfaces(:,'name')); "Custom"];
vehiclesNames = [table2array(vehicles(:,'name')); "Custom"];

set(handles.menuGravity,'String',gravitiesNames);
set(handles.menuSurfaceType,'String',surfacesNames);
set(handles.menuVehiclePresets,'String',vehiclesNames);

% set all the defaults
resetValues(handles);


% --- Outputs from this function are returned to the command line.
function varargout = simulator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%% FREQUENTLY USED FUNCTIONS %%%

% sets a string field to a numeric value
function setStrNum(hObject, value)
set(hObject,'String',num2str(value, [2,2]));

% gets a double value from a string field
function num = getStrNum(hObject)
num = str2double(get(hObject,'String'));

% sets a menu to the "Custom" option (which is always the last option)
function setMenuToCustom(hObject)
value = length(get(hObject,'String'));
set(hObject,'Value',value);

% Check that input number is valid (to disable min/max checking, set to `[]`)
function value = validateNumber(hObject, default, min, max)
value = getStrNum(hObject);
acceptedValue = default;
if (isnan(value))
    disp('ERROR: Not a number!');
elseif (~isempty(min) && value < min)
    disp('ERROR: Value too low!');
elseif (~isempty(max) && value > max)
    disp('ERROR: Value too high!');
else
    acceptedValue = value;
end
setStrNum(hObject, acceptedValue);

% resets all GUI values to defaults
function resetValues(handles)
set(handles.textSuccess,'String','');
set(handles.textOutcome,'String','');

set(handles.checkboxBrakes, 'Value', 1);
set(handles.editReactionTime,'String','2');

set(handles.checkboxRain, 'Value', 0);
set(handles.menuSurfaceType, 'Value', 1);
set(handles.menuGravity, 'Value', 4);
updateEnvironment(handles);

set(handles.menuVehiclePresets, 'Value', 2);
updateVehicle(handles);

set(handles.editVelInit,'String','15');
set(handles.editDistanceTree,'String','100');

cla(handles.axesPos);
cla(handles.axesVel);
cla(handles.axesAcc);



%%% BUTTON CALLBACKS %%%

function btnGo_Callback(hObject, eventdata, handles)
t=0;
dt=0.01;

% starting conditions variables
pos = 0;
vel = getStrNum(handles.editVelInit);
acc = 0;
posTree = getStrNum(handles.editDistanceTree);

% braking variables
brakesEnabled = get(handles.checkboxBrakes, 'Value');
timeReaction = getStrNum(handles.editReactionTime);

% vehicle variables
vehicleMass = getStrNum(handles.editVehicleMass);
brakingEfficiency = getStrNum(handles.editBrakingEfficiency);

% environment variables
coeffFriction = getStrNum(handles.editCoeffFriction);
gravity = -9.81 * getStrNum(handles.editGravity);

k=0;
vecPos = [];
vecVel = [];
vecAcc = [];
while vel > 0 && pos < posTree
    k = k+1;
    t = t + dt;
    
    % update the vectors
    vecPos(k) = pos;
    vecVel(k) = vel;
    vecAcc(k) = acc;
    
    % apply brakes
    if brakesEnabled && t >= timeReaction
        acc = gravity * coeffFriction * (brakingEfficiency / 100);
    end
    
    % update velocity and position
    vel = vel + acc*dt;
    pos = pos + vel*dt;
end
vecTime = dt:dt:k*dt;

% plot position
axes(handles.axesPos);
plot(vecTime,vecPos);
xlabel('Time (s)');
ylabel('Position (m)');

% plot velocity
axes(handles.axesVel);
plot(vecTime,vecVel);
xlabel('Time (s)');
ylabel('Velocity (m/s)');

% plot acceleration
axes(handles.axesAcc);
plot(vecTime,vecAcc);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');

% display results

if (pos >= posTree)
    % we're approximating that the vehicle stops in 0.2s
    force = vehicleMass * (vel / 0.2);
    
    message = "You hit the tree!";
    color = 'red';
    outcome = compose("Impact force:  %0.2f N\n", force);
    outcome = outcome+compose("Time to impact:  %0.2f s\n", k*dt);
    outcome = outcome+compose("Final velocity:  %0.2f m/s\n", vecVel(k));
else
    message = "You stopped safely.";
    color = [0,0.5,0];
    outcome = compose("Stopping distance:  %0.2f m\n", pos);
    outcome = outcome+compose("Stopping time:  %0.2f s\n", k*dt);
end
set(handles.textSuccess,'String',message,'ForegroundColor',color);
set(handles.textOutcome,'String',outcome);

function btnReset_Callback(hObject, eventdata, handles)
resetValues(handles);



%%% BRAKING CALLBACKS %%%

function checkboxBrakes_Callback(hObject, eventdata, handles)

function editReactionTime_Callback(hObject, eventdata, handles)
validateNumber(hObject, 2.0, 0, []);



%%% VEHICLE CALLBACKS %%%

function updateVehicle(handles)
global vehicles;
choiceVehicle = get(handles.menuVehiclePresets, 'Value');

vehicleMass = getStrNum(handles.editVehicleMass);
brakingEfficiency = getStrNum(handles.editBrakingEfficiency);

if choiceVehicle <= size(vehicles,1)
    vehicleMass = table2array(vehicles(choiceVehicle, 'mass'));
    brakingEfficiency = table2array(vehicles(choiceVehicle, 'brakingEfficiency'))*100;
end

setStrNum(handles.editVehicleMass, vehicleMass);
setStrNum(handles.editBrakingEfficiency, brakingEfficiency);

function menuVehiclePresets_Callback(hObject, eventdata, handles)
updateVehicle(handles);

function editVehicleMass_Callback(hObject, eventdata, handles)
validateNumber(hObject, 1200, 0, []);
setMenuToCustom(handles.menuVehiclePresets);

function editBrakingEfficiency_Callback(hObject, eventdata, handles)
validateNumber(hObject, 50.0, 0, 100);
setMenuToCustom(handles.menuVehiclePresets);



%%% ENVIRONMENT CALLBACKS %%%

% updates environment editboxes based on dropdown menus
function updateEnvironment(handles)
global gravities surfaces;
choiceSurfaceType = get(handles.menuSurfaceType, 'Value');
choiceGravity = get(handles.menuGravity, 'Value');
isRaining = get(handles.checkboxRain, 'Value');

% retrieve old gravity/coeff from GUI
gravity = getStrNum(handles.editGravity);
coeffFriction = getStrNum(handles.editCoeffFriction);

% find new gravity/coeff from tables
if choiceGravity <= size(gravities,1)
    gravity = table2array(gravities(choiceGravity, 'accel'));
end
if choiceSurfaceType <= size(surfaces,1)
    if isRaining == 1
        col = 'coeffWet';
    else
        col = 'coeffDry';
    end
    coeffFriction = table2array(surfaces(choiceSurfaceType, col));
end

% update gravity/coeff in GUI
setStrNum(handles.editGravity,gravity);
setStrNum(handles.editCoeffFriction,coeffFriction);

function menuSurfaceType_Callback(hObject, eventdata, handles)
updateEnvironment(handles)

function menuGravity_Callback(hObject, eventdata, handles)
updateEnvironment(handles)

function checkboxRain_Callback(hObject, eventdata, handles)
updateEnvironment(handles)

function editCoeffFriction_Callback(hObject, eventdata, handles)
validateNumber(hObject, 0.7, 0, 1);
setMenuToCustom(handles.menuSurfaceType);
set(handles.checkboxRain, 'Value', 0);

function editGravity_Callback(hObject, eventdata, handles)
validateNumber(hObject, 9.81, 0, []);
setMenuToCustom(handles.menuGravity);



%%% STARTING CONDITIONS CALLBACKS %%%

function editVelInit_Callback(hObject, eventdata, handles)
validateNumber(hObject, 15.0, 0, []);

function editDistanceTree_Callback(hObject, eventdata, handles)
validateNumber(hObject, 100.0, 0, []);



%%% MISC CALLBACKS %%%

% shared create function for all popup menus and edit boxes
function genericCreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
