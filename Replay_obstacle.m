function varargout = Replay_obstacle(varargin)
% REPLAY_OBSTACLE MATLAB code for Replay_obstacle.fig
%      REPLAY_OBSTACLE, by itself, creates a new REPLAY_OBSTACLE or raises the existing
%      singleton*.
%
%      H = REPLAY_OBSTACLE returns the handle to a new REPLAY_OBSTACLE or the handle to
%      the existing singleton*.
%
%      REPLAY_OBSTACLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REPLAY_OBSTACLE.M with the given input arguments.
%
%      REPLAY_OBSTACLE('Property','Value',...) creates a new REPLAY_OBSTACLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Replay_obstacle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Replay_obstacle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Replay_obstacle

% Last Modified by GUIDE v2.5 15-Nov-2019 20:55:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Replay_obstacle_OpeningFcn, ...
                   'gui_OutputFcn',  @Replay_obstacle_OutputFcn, ...
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


% --- Executes just before Replay_obstacle is made visible.
function Replay_obstacle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Replay_obstacle (see VARARGIN)

% Choose default command line output for Replay_obstacle
handles.output = hObject;
handles.timer = 0;
handles.bp = 0;
handles.count = 0;
handles.filereadflag = 0;
handles.datareadflag = 0;
handles.timedot = 0.5;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Replay_obstacle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Replay_obstacle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
handles.String = 'sss';
dirs=dir('data/*.json');
[m,n]= size(dirs);
c= {};
for ii=1:m
c =[c,dirs(ii).name];
end
%set(handles.listbox1,'string',filename);
set(handles.listbox1,'string',c);

index = get(handles.listbox1,'Value'); 
file_list =get(handles.listbox1,'String');  
ob_filename = file_list{index};
if strcmp(ob_filename,'') <0.5
    handles.filereadflag = 1;
    set(handles.text7,'string','File load succeed!');
end
handles.ob_filename = ob_filename;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.ob_filename
if handles.filereadflag > 0.5
    file_name = ['data/',handles.ob_filename];
    data = loadjson(file_name);
    handles.data = data;
    handles.datareadflag = 1;
    [m,n]= size(data.pathpoint.x);
    handles.datalen = m;
    %set(handles.edit3,'string', handles.data.ID0.x_y(1));
    handles.text7.String = [[handles.text7.String,10] ['Data load succeed! ',10]];
    guidata(hObject,handles);
else
    errordlg('FileReadError!','Bad Input','modal'); 
end

    

% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
%hObject.string = handles.ob_filename;


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.datareadflag >0.5
if handles.filereadflag > 0.5
    handles.count = handles.count + 1;
    guidata(hObject,handles);
  %  set(handles.edit3,'string',handles.count);
    if handles.bp < 0.5
        set(handles.pushbutton2,'string','PAUSE');   
        handles.bp = 1;
        guidata(hObject,handles);
        set(handles.edit2,'string', handles.bp);
    else 
        handles.bp = 0;
        guidata(hObject,handles);
        set(handles.pushbutton2,'string','BEGIN');
        set(handles.edit2,'string', handles.bp);
        return;
    end
    while ( handles.pushbutton2.String =='PAUSE' )     
        pause(handles.timedot)
        hold off;
        handles.timer = handles.timer +1;
        if handles.timer > handles.datalen
            h=dialog('name','warning.','position',[200 200 200 70]);
            uicontrol('parent',h,'style','text','string','Replay is over! ','position',[50 40 120 20],'fontsize',12);
            uicontrol('parent',h,'style','pushbutton','position',...
            [80 10 50 20],'string','Sure','callback','delete(gcbf)');
            break;
        end
        set(handles.text9,'string',handles.timer);
        set(handles.edit2,'string', handles.bp);
        axes(handles.axes1);
        plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
        text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
        axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
        hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
               % ['data_sub = handles.data.',name_sub']
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
                set(handles.edit3,'string',data_sub.x_y(1));
            end
    end
    if (handles.pushbutton2.String =='BEGIN')
        handles.bp = 0;
        set(handles.edit2,'string', handles.bp);
    end
else
    errordlg('FileReadError!','Bad Input','modal'); 
    %set(handles.edit3,'string','file_error');
end
else
    errordlg('DataReadError!','Bad Input','modal'); 
end
guidata(hObject,handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit4.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        handles.timedot = user_entry;
        guidata(hObject,handles);
    end
end


% --- Executes during object creation, after setting all properties.
function text9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
            hold off;
            handles.timer = user_entry;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
        guidata(hObject,handles);
    end
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry-5>0
            hold off;
            handles.timer = user_entry-5;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must > 0 ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry-3>0
            hold off;
            handles.timer = user_entry-3;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must > 0 ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry-1>0
            hold off;
            handles.timer = user_entry-1;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must > 0 ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry+1<= handles.datalen
            hold off;
            handles.timer = user_entry+1;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must < max ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry+5<= handles.datalen
            hold off;
            handles.timer = user_entry+5;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must < max ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
user_string = handles.edit1.String;    
user_entry= str2double(user_string); 
if isnan(user_entry)      
     errordlg('You must entry a number value','Bad Input','modal');   
else 
    if handles.bp > 0.5 
        errordlg('You can only entry when pause','Bad Input','modal'); 
    else
        %  handles.time = user_entry;
         if user_entry+3<= handles.datalen
            hold off;
            handles.timer = user_entry+3;
            handles.edit1.String = handles.timer;
            set(handles.text9,'string',handles.timer);
            set(handles.edit2,'string', handles.bp);
            axes(handles.axes1);
            plot(handles.data.pathpoint.x(handles.timer,:),handles.data.pathpoint.y(handles.timer,:),'color','k');
            text(handles.data.pathpoint.x(handles.timer,1),handles.data.pathpoint.y(handles.timer,1),'PathPoint','color','k')
            axis([handles.data.pathpoint.x(handles.timer,1)-100 handles.data.pathpoint.x(handles.timer,1)+100 handles.data.pathpoint.y(handles.timer,1)-100 handles.data.pathpoint.y(handles.timer,1)+100])
            hold on;
        
            for ii = 0:31
                name_sub = ['ID',num2str(ii)];
                eval(['data_sub = handles.data.',name_sub,';']);
                plot(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),'.','MarkerSize',12);
                hold on;
                if data_sub.isvalid(handles.timer) >0.5 
                    text(data_sub.x_y(handles.timer,1),data_sub.x_y(handles.timer,2),name_sub,'color','k');
                    plot(data_sub.tra_x(handles.timer,:),data_sub.tra_y(handles.timer,:));
                end
              %  set(handles.edit3,'string',data_sub.x_y(1));
            end
         else 
              errordlg('Counter must < max ','Bad Input','modal');
         end
        guidata(hObject,handles);
    end
end
