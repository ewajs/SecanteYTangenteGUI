function varargout = secante(varargin)
% SECANTE M-file for secante.fig
%      SECANTE, by itself, creates a new SECANTE or raises the existing
%      singleton*.
%
%      H = SECANTE returns the handle to a new SECANTE or the handle to
%      the existing singleton*.
%
%      SECANTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECANTE.M with the given input arguments.
%
%      SECANTE('Property','Value',...) creates a new SECANTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before secante_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to secante_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help secante

% Last Modified by GUIDE v2.5 21-Apr-2013 23:07:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @secante_OpeningFcn, ...
                   'gui_OutputFcn',  @secante_OutputFcn, ...
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


% --- Executes just before secante is made visible.
function secante_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to secante (see VARARGIN)

% Choose default command line output for secante
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes secante wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = secante_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtFunc_Callback(hObject, eventdata, handles)
% hObject    handle to txtFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    
% Hints: get(hObject,'String') returns contents of txtFunc as text
%        str2double(get(hObject,'String')) returns contents of txtFunc as a double


% --- Executes during object creation, after setting all properties.
function txtFunc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over txtFunc.
function txtFunc_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to txtFunc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(hObject,'String'),'Coloque función aquí'))%Lo dejo listo para recibir la función
    set(hObject,'ForegroundColor','k');
    set(hObject,'String','');
    set(hObject,'Enable','on');
    uicontrol(hObject);
end


% --- Executes on button press in btnGraficar.
function btnGraficar_Callback(hObject, eventdata, handles)
% hObject    handle to btnGraficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%RECOPILACIÓN DE LA INFORMACÍON DEL GUI START
xmin = str2double(get(handles.txtXmin,'String'));
xmax = str2double(get(handles.txtXmax,'String'));
ymin = str2double(get(handles.txtYmin,'String'));
ymax = str2double(get(handles.txtYmax,'String'));
intervalo = [xmin xmax ymin ymax];
funcion = inline(vectorize(get(handles.txtFunc,'String')));
Xa = get(handles.sldXa,'Value');
Xb = get(handles.sldXb,'Value');
%RECOPILACIÓN DE LA INFORMACÍON DEL GUI END

%MODIFICO GUI START
set(handles.lblXamin,'String',get(handles.txtXmin,'String'));
set(handles.lblXamax,'String',get(handles.txtXmax,'String'));
set(handles.lblXbmin,'String',get(handles.txtXmin,'String'));
set(handles.lblXbmax,'String',get(handles.txtXmax,'String'));
set(handles.sldXa,'Min',xmin);
set(handles.sldXb,'Min',xmin);
set(handles.sldXa,'Max',xmax);
set(handles.sldXb,'Max',xmax);
set(handles.lblHistoria,'String','Historia');
%MODIFICO GUI STOP

%GENERACIÓN DE TIRAS DE DATOS DE LA FUNCIÓN START
X = xmin:(xmax-xmin)/1000:xmax; %Intervalo resolución 1000 ptos
Y = funcion(X);
Ya = funcion(Xa);
Yb = funcion(Xb);
%GENERACIÓN DE TIRAS DE DATOS DE LA FUNCIÓN END

cla; %Limpio el gráfico

%GRABO LOS DATOS START
handles.xmin = xmin;
handles.xmax = xmax;
handles.ymin = ymin;
handles.ymax = ymax;
handles.intervalo = intervalo;
handles.funcion = funcion;
handles.X = X;
handles.Y = Y;
handles.flag_historia = 0; %reseteo todas las secantes
handles.n = 1; %Contador de secante en 1
guidata(hObject,handles);
%GRABO LOS DATOS END
sldXa_Callback(handles.sldXa,0,handles); %Llamo al Callback que dibuja la secante y la función


function txtXmin_Callback(hObject, eventdata, handles)
% hObject    handle to txtXmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtXmin as text
%        str2double(get(hObject,'String')) returns contents of txtXmin as a double


% --- Executes during object creation, after setting all properties.
function txtXmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtXmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtYmin_Callback(hObject, eventdata, handles)
% hObject    handle to txtYmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtYmin as text
%        str2double(get(hObject,'String')) returns contents of txtYmin as a double


% --- Executes during object creation, after setting all properties.
function txtYmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtYmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtXmax_Callback(hObject, eventdata, handles)
% hObject    handle to txtXmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtXmax as text
%        str2double(get(hObject,'String')) returns contents of txtXmax as a double


% --- Executes during object creation, after setting all properties.
function txtXmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtXmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtYmax_Callback(hObject, eventdata, handles)
% hObject    handle to txtYmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtYmax as text
%        str2double(get(hObject,'String')) returns contents of txtYmax as a double


% --- Executes during object creation, after setting all properties.
function txtYmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtYmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chkHold.
function chkHold_Callback(hObject, eventdata, handles)
% hObject    handle to chkHold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkHold


% --- Executes on selection change in lstColor.
function lstColor_Callback(hObject, eventdata, handles)
% hObject    handle to lstColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lista = get(hObject,'String');
handles.colorfunc = lista{get(hObject,'Value')};%Asigno el string que corresponde al valor de color.
switch (handles.colorfunc) %traduzco el color solicitado para el gráfico
    case 'Azul'
        handles.colorfunc = 'b';
    case 'Rojo'
        handles.colorfunc = 'r';
    case 'Verde'
        handles.colorfunc = 'g';
    case 'Amarillo'
        handles.colorfunc = 'y';
    case 'Magenta'
        handles.colorfunc = 'm';
    case 'Cian'
        handles.colorfunc = 'c';
    case 'Negro'
        handles.colorfunc = 'k';
end
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstColor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstColor


% --- Executes during object creation, after setting all properties.
function lstColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.colorfunc = 'b';
guidata(hObject,handles);



function txtGrosor_Callback(hObject, eventdata, handles)
% hObject    handle to txtGrosor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtGrosor as text
%        str2double(get(hObject,'String')) returns contents of txtGrosor as a double


% --- Executes during object creation, after setting all properties.
function txtGrosor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtGrosor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function sldXa_Callback(hObject, eventdata, handles)
% hObject    handle to sldXa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%OBTENGO LOS DATOS DEL GUI START
Xa = get(hObject,'Value');
Xb = get(handles.sldXb,'Value');
n = handles.n;
%OBTENGO DATOS DEL GUI STOP
%CALCULO START
Ya = handles.funcion(Xa);
Yb = handles.funcion(Xb);
%CALCULO STOP
%ACTUALIZAR GUI START
set(handles.lblXa,'String',horzcat('Xa = ',num2str(Xa)));
%ACTUALIZAR GUI STOP
%GRAFICO START
cla; %Limpio el gráfico
plot(handles.X,handles.Y,'Color',handles.colorfunc,'LineWidth',1);
hold on;
if (handles.flag_historia)
    for i = 1:(n-1)
        plot(handles.X,handles.Ysechist{i},'Color',handles.Colorhist{i},'LineWidth',2);
    end
end
plot(Xa,Ya,Xb,Yb,'Color',handles.colorsec,'Marker','o'); %Grafico las posiciones de Xa y Xb
plot([Xa Xa],[handles.ymin handles.ymax],'Color',handles.colorsec,'LineStyle',':');%Marcador vertical de Xa
plot([Xb Xb],[handles.ymin handles.ymax],'Color',handles.colorsec,'LineStyle',':');%Marcador vertical de Xb
if (get(handles.chkEjes,'Value'))
    plot([handles.xmin handles.xmax],[0 0],'Color','k','LineWidth',2);
    plot([0 0],[handles.ymin handles.ymax],'Color','k','LineWidth',2);
end
axis(handles.intervalo);
if(handles.flag_grilla)
    grid on;
end
%GRAFICO STOP
[m,b] = calcularsecante(Xa,Xb,Ya,Yb);
Ysec = m.*(handles.X)+b;
plot(handles.X,Ysec,'Color',handles.colorsec,'LineWidth',1);
if (b < 0)
    signo = '- ';
    b = -b;
else
    signo = '+ ';
end
if (abs(m) < 0.0001) %Redondeo para evitar error numérico
    m = 0;
end
set(handles.lblInfo,'String',[{'Ecuación de la Recta'},{horzcat('Y = ',num2str(m),'X ',signo, num2str(b))}]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sldXa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldXa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sldXb_Callback(hObject, eventdata, handles)
% hObject    handle to sldXb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%OBTENGO LOS DATOS DEL GUI START
Xb = get(hObject,'Value');
Xa = get(handles.sldXa,'Value');
n = handles.n;
%OBTENGO DATOS DEL GUI STOP
%CALCULO START
Ya = handles.funcion(Xa);
Yb = handles.funcion(Xb);
%CALCULO STOP
%ACTUALIZAR GUI START
set(handles.lblXb,'String',horzcat('Xb = ',num2str(Xb)));
%ACTUALIZAR GUI STOP
%GRAFICO START
cla; %Limpio el gráfico
plot(handles.X,handles.Y,'Color',handles.colorfunc,'LineWidth',1);
hold on;
if (handles.flag_historia)
    for i = 1:(n-1)
        plot(handles.X,handles.Ysechist{i},'Color',handles.Colorhist{i},'LineWidth',1);
    end
end
plot(Xa,Ya,Xb,Yb,'Color',handles.colorsec,'Marker','o');
plot([Xa Xa],[handles.ymin handles.ymax],'Color',handles.colorsec,'LineStyle',':');%Marcador vertical de Xa
plot([Xb Xb],[handles.ymin handles.ymax],'Color',handles.colorsec,'LineStyle',':');%Marcador vertical de Xb
if (get(handles.chkEjes,'Value'))
    plot([handles.xmin handles.xmax],[0 0],'Color','k','LineWidth',2);
    plot([0 0],[handles.ymin handles.ymax],'Color','k','LineWidth',2);
end
axis(handles.intervalo);
if(handles.flag_grilla)
    grid on;
end
%GRAFICO STOP
[m,b] = calcularsecante(Xa,Xb,Ya,Yb);
Ysec = m.*(handles.X)+b;
plot(handles.X,Ysec,'Color',handles.colorsec,'LineWidth',1);
if (b < 0)
    signo = '- ';
    b = -b;
else
    signo = '+ ';
end
if (abs(m) < 0.0001) %Redondeo para evitar error numérico
    m = 0;
end
set(handles.lblInfo,'String',[{'Ecuación de la Recta'},{horzcat('Y = ',num2str(m),'X ',signo, num2str(b))}]);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sldXb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldXb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on selection change in lstColorSec.
function lstColorSec_Callback(hObject, eventdata, handles)
% hObject    handle to lstColorSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lista = get(hObject,'String');
handles.colorsec = lista{get(hObject,'Value')};%Asigno el string que corresponde al valor de color.
switch (handles.colorsec) %traduzco el color solicitado para el gráfico
    case 'Azul'
        handles.colorsec = 'b';
    case 'Rojo'
        handles.colorsec = 'r';
    case 'Verde'
        handles.colorsec = 'g';
    case 'Amarillo'
        handles.colorsec = 'y';
    case 'Magenta'
        handles.colorsec = 'm';
    case 'Cian'
        handles.colorsec = 'c';
    case 'Negro'
        handles.colorsec = 'k';
end
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns lstColorSec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstColorSec


% --- Executes during object creation, after setting all properties.
function lstColorSec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstColorSec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.colorsec = 'r';
guidata(hObject,handles);

% --- Executes on button press in btnSecante.
function btnSecante_Callback(hObject, eventdata, handles)
% hObject    handle to btnSecante (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function lblInfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lblInfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String','');


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function [m,b] = calcularsecante (Xa, Xb, Ya, Yb)
m = (Ya-Yb)/(Xa-Xb);
b = Ya-m*Xa;


% --- Executes on button press in btn_guardar.
function btn_guardar_Callback(hObject, eventdata, handles)
% hObject    handle to btn_guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%OBTENGO LOS DATOS DEL GUI START
Xb = get(handles.sldXb,'Value');
Xa = get(handles.sldXa,'Value');
%OBTENGO DATOS DEL GUI STOP
%CALCULO START
Ya = handles.funcion(Xa);
Yb = handles.funcion(Xb);
[m,b] = calcularsecante (Xa, Xb, Ya, Yb);
%CALCULO STOP
%PREPARO VALORES
Ysec = m.*handles.X + b;
handles.Ysechist{handles.n} = Ysec; 
handles.Colorhist{handles.n} = handles.colorsec;
handles.n = handles.n + 1;
handles.flag_historia = 1;
if (b < 0)
    signo = '- ';
    b = -b;
else
    signo = '+ ';
end
if (abs(m) < 0.0001) %Redondeo para evitar error numérico
    m = 0;
end
m = round(m*100)/100;%Solo dos decimales.
b = round(b*100)/100;
lista = get(handles.lstColorSec,'String');
color{1} = lista{get(handles.lstColorSec,'Value')}%Los creo como Cell para poder concatenarlos
str = get(handles.lblHistoria,'String');
aux{1} = horzcat('Y = ', num2str(m), 'X ', signo, num2str(b))
str = [str; color; aux];
set(handles.lblHistoria,'String',str);
get(handles.lstColorSec,'Max')
switch (get(handles.lstColorSec,'Value'))%Paso al color siguiente
        case 1
            set(handles.lstColorSec,'Value',2);
            handles.colorsec = 'k';
        case 2
            set(handles.lstColorSec,'Value',3);
            handles.colorsec = 'y';
        case 3
            set(handles.lstColorSec,'Value',4);
            handles.colorsec = 'g';
        case 4
            set(handles.lstColorSec,'Value',5);
            handles.colorsec = 'm';
        case 5
            set(handles.lstColorSec,'Value',6);
            handles.colorsec = 'c';
        case 6
            set(handles.lstColorSec,'Value',7);
            handles.colorsec = 'b';
    case 7
            set(handles.lstColorSec,'Value',1);
            handles.colorsec = 'r';
    end

guidata(hObject,handles);


% --- Executes on button press in togGrilla.
function togGrilla_Callback(hObject, eventdata, handles)
% hObject    handle to togGrilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togGrilla
if (get(hObject,'Value'))
    handles.flag_grilla = 1;
    set(hObject,'String','Grilla OFF');
    grid on;
else
    handles.flag_grilla = 0;
    set(hObject,'String','Grilla ON');
    grid off;
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function togGrilla_CreateFcn(hObject, eventdata, handles)
% hObject    handle to togGrilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.flag_grilla = 0;
guidata(hObject,handles);


% --- Executes on button press in chkEjes.
function chkEjes_Callback(hObject, eventdata, handles)
% hObject    handle to chkEjes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkEjes


% --- Executes on button press in btnXamenos.
function btnXamenos_Callback(hObject, eventdata, handles)
% hObject    handle to btnXamenos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldXa,'Value');
val = val - (get(handles.sldXa,'Max')-get(handles.sldXa,'Min'))/100;
set(handles.sldXa,'Value',val);
sldXa_Callback(handles.sldXa,0,handles);


% --- Executes on button press in btnXbmenos.
function btnXbmenos_Callback(hObject, eventdata, handles)
% hObject    handle to btnXbmenos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldXb,'Value');
val = val - (get(handles.sldXb,'Max')-get(handles.sldXb,'Min'))/100;
set(handles.sldXb,'Value',val);
sldXb_Callback(handles.sldXb,0,handles);

% --- Executes on button press in btnXamas.
function btnXamas_Callback(hObject, eventdata, handles)
% hObject    handle to btnXamas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldXa,'Value');
val = val + (get(handles.sldXa,'Max')-get(handles.sldXa,'Min'))/100;
set(handles.sldXa,'Value',val);
sldXa_Callback(handles.sldXa,0,handles);

% --- Executes on button press in btnXbmas.
function btnXbmas_Callback(hObject, eventdata, handles)
% hObject    handle to btnXbmas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldXb,'Value');
val = val + (get(handles.sldXb,'Max')-get(handles.sldXb,'Min'))/100;
set(handles.sldXb,'Value',val);
sldXb_Callback(handles.sldXb,0,handles);
