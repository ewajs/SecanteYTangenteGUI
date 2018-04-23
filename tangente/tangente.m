function varargout = tangente(varargin)
% TANGENTE M-file for tangente.fig
%      TANGENTE, by itself, creates a new TANGENTE or raises the existing
%      singleton*.
%
%      H = TANGENTE returns the handle to a new TANGENTE or the handle to
%      the existing singleton*.
%
%      TANGENTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TANGENTE.M with the given input arguments.
%
%      TANGENTE('Property','Value',...) creates a new TANGENTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tangente_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tangente_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tangente

% Last Modified by GUIDE v2.5 25-Apr-2013 01:04:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tangente_OpeningFcn, ...
                   'gui_OutputFcn',  @tangente_OutputFcn, ...
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


% --- Executes just before tangente is made visible.
function tangente_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tangente (see VARARGIN)

% Choose default command line output for tangente
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tangente wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tangente_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in btnGraf.
function btnGraf_Callback(hObject, eventdata, handles)
% hObject    handle to btnGraf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%RECOPILACIÓN DE LA INFORMACÍON DEL GUI START
xmin = str2double(get(handles.txtXmin,'String'));
xmax = str2double(get(handles.txtXmax,'String'));
ymin = str2double(get(handles.txtYmin,'String'));
ymax = str2double(get(handles.txtYmax,'String'));
intervalo = [xmin xmax ymin ymax];
funcion = inline(vectorize(get(handles.txtFunc,'String')));
f = sym(get(handles.txtFunc,'String'));
fprima = diff(f);
Xa = get(handles.sldX,'Value');
%RECOPILACIÓN DE LA INFORMACÍON DEL GUI END

%MODIFICO GUI START
set(handles.sldX,'Min',xmin);
set(handles.sldX,'Max',xmax);
%MODIFICO GUI STOP

%GENERACIÓN DE TIRAS DE DATOS DE LA FUNCIÓN START
X = xmin:(xmax-xmin)/1000:xmax; %Intervalo resolución 1000 ptos
Y = funcion(X);
%GENERACIÓN DE TIRAS DE DATOS DE LA FUNCIÓN END

%GRABO LOS DATOS START
handles.xmin = xmin;
handles.xmax = xmax;
handles.ymin = ymin;
handles.ymax = ymax;
handles.intervalo = intervalo;
handles.funcion = funcion
handles.f = f;
handles.fprima = fprima;
handles.X = X;
handles.Y = Y;
handles.flag_historia = 0; %reseteo todas las tangentes
handles.n = 1; %Contador de tangente en 1
guidata(hObject,handles);
%GRABO LOS DATOS END
sldX_Callback(handles.sldX,1,handles);



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


% --- Executes on selection change in popColor.
function popColor_Callback(hObject, eventdata, handles)
% hObject    handle to popColor (see GCBO)
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
% Hints: contents = cellstr(get(hObject,'String')) returns popColor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popColor


% --- Executes during object creation, after setting all properties.
function popColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.colorfunc = 'b';
guidata(hObject,handles);


% --- Executes on button press in togGrilla.
function togGrilla_Callback(hObject, eventdata, handles)
% hObject    handle to togGrilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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

% Hint: get(hObject,'Value') returns toggle state of togGrilla


% --- Executes on button press in chkEjes.
function chkEjes_Callback(hObject, eventdata, handles)
% hObject    handle to chkEjes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkEjes


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


% --- Executes during object creation, after setting all properties.
function togGrilla_CreateFcn(hObject, eventdata, handles)
% hObject    handle to togGrilla (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.flag_grilla = 0;
guidata(hObject,handles);


% --- Executes on slider movement.
function sldX_Callback(hObject, eventdata, handles)
% hObject    handle to sldX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%OBTENGO LOS DATOS DEL GUI START
Xa = get(hObject,'Value');
n = handles.n;
%OBTENGO DATOS DEL GUI STOP
%CALCULO START
Ya = handles.funcion(Xa);
%CALCULO STOP
%ACTUALIZAR GUI START
set(handles.txtX,'String',num2str(Xa));
%ACTUALIZAR GUI STOP
%GRAFICO START
cla; %Limpio el gráfico
hold on;
if (get(handles.chkEjes,'Value'))
    plot([handles.xmin handles.xmax],[0 0],'Color','k','LineWidth',1);
    plot([0 0],[handles.ymin handles.ymax],'Color','k','LineWidth',1);
end
plot(handles.X,handles.Y,'Color',handles.colorfunc,'LineWidth',1);
if (handles.flag_historia)
    for i = 1:(n-1)
        plot(handles.X,handles.Ytanhist{i},'Color',handles.Colorhist{i},'LineWidth',1);
    end
end
[m,b] = CalcTg(Xa,handles); 
Ytg = m.*handles.X + b;
plot(handles.X,Ytg,'Color',handles.colortan,'LineWidth',1);
plot([Xa Xa],[handles.ymin handles.ymax],'Color',handles.colortan,'LineStyle',':');%Marcador vertical de Xa
plot(Xa,Ya,'Color',handles.colortan,'Marker','o','MarkerFaceColor','w'); %Grafico la posicion de Xa
axis(handles.intervalo);
if(handles.flag_grilla)
    grid on;
end
%GRÁFICO STOP

%IMPRIMO INFO EN GUI START
if (b < 0)
    signo = '- ';
    b = -b;
else
    signo = '+ ';
end
if (abs(m) < 0.00001) %Redondeo para evitar error numérico
    m = 0;
end
set(handles.txtInfo,'String',[{'Ecuación de la Recta Tangente'},{horzcat('Y = ',num2str(m),'X ',signo, num2str(b))}]);


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sldX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sldX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in btnmenos.
function btnmenos_Callback(hObject, eventdata, handles)
% hObject    handle to btnmenos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldX,'Value');
val = val - (get(handles.sldX,'Max')-get(handles.sldX,'Min'))/100;
if (val > get(handles.sldX,'Min')) %Si ya no estoy a tope
    set(handles.sldX,'Value',val);
    sldX_Callback(handles.sldX,0,handles);
end

% --- Executes on button press in btnmas.
function btnmas_Callback(hObject, eventdata, handles)
% hObject    handle to btnmas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.sldX,'Value');
val = val + (get(handles.sldX,'Max')-get(handles.sldX,'Min'))/100;
if (val < get(handles.sldX,'Max')) %Si ya no estoy a tope
    set(handles.sldX,'Value',val);
    sldX_Callback(handles.sldX,0,handles);
end



% --- Executes on selection change in popColortg.
function popColortg_Callback(hObject, eventdata, handles)
% hObject    handle to popColortg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lista = get(hObject,'String');
handles.colortan = lista{get(hObject,'Value')};%Asigno el string que corresponde al valor de color.
switch (handles.colorsec) %traduzco el color solicitado para el gráfico
    case 'Azul'
        handles.colortan = 'b';
    case 'Rojo'
        handles.colortan = 'r';
    case 'Verde'
        handles.colortan = 'g';
    case 'Amarillo'
        handles.colortan = 'y';
    case 'Magenta'
        handles.colortan = 'm';
    case 'Cian'
        handles.colortan = 'c';
    case 'Negro'
        handles.colortan = 'k';
end
guidata(hObject,handles);

% Hints: contents = cellstr(get(hObject,'String')) returns popColortg contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popColortg


% --- Executes during object creation, after setting all properties.
function popColortg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popColortg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.colortan = 'r';
guidata(hObject,handles);

% --- Executes on button press in btnNext.
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%OBTENGO LOS DATOS DEL GUI START
Xa = get(handles.sldX,'Value');
%OBTENGO DATOS DEL GUI STOP
%CALCULO START
[m,b] = CalcTg (Xa, handles);
%CALCULO STOP
%PREPARO VALORES
Ytan = m.*handles.X + b;
handles.Ytanhist{handles.n} = Ytan; 
handles.Colorhist{handles.n} = handles.colortan;
handles.n = handles.n + 1;
handles.flag_historia = 1;
if (b < 0)
    signo = '- ';
    b = -b;
else
    signo = '+ ';
end
if (abs(m) < 0.00001) %Redondeo para evitar error numérico
    m = 0;
end
m = round(m*100)/100;%Solo dos decimales.
b = round(b*100)/100;
lista = get(handles.popColortg,'String');
color{1} = lista{get(handles.popColortg,'Value')}%Los creo como Cell para poder concatenarlos
str = get(handles.txtHistoria,'String');
aux{1} = horzcat('Y = ', num2str(m), 'X ', signo, num2str(b));
str = [str; color;{horzcat('X = ',num2str(Xa))}; aux];
set(handles.txtHistoria,'String',str);
get(handles.popColortg,'Max')
switch (get(handles.popColortg,'Value'))%Paso al color siguiente
        case 1
            set(handles.popColortg,'Value',2);
            handles.colortan = 'k';
        case 2
            set(handles.popColortg,'Value',3);
            handles.colortan = 'y';
        case 3
            set(handles.popColortg,'Value',4);
            handles.colortan = 'g';
        case 4
            set(handles.popColortg,'Value',5);
            handles.colortan = 'm';
        case 5
            set(handles.popColortg,'Value',6);
            handles.colortan = 'c';
        case 6
            set(handles.popColortg,'Value',7);
            handles.colortan = 'b';
        case 7
            set(handles.popColortg,'Value',1);
            handles.colortan = 'r';
    end

guidata(hObject,handles);


function [m,b] = CalcTg(Xa,handles)
fn =inline(vectorize(char(handles.f)));
fm = inline(vectorize(char(handles.fprima)));
m = fm(Xa)
b = fn(Xa)-m*Xa
Xa



function txtX_Callback(hObject, eventdata, handles)
% hObject    handle to txtX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curr = str2num(get(hObject,'String'));
if (curr < get(handles.sldX,'Max') && curr > get(handles.sldX,'Min'))
    set(handles.sldX,'Value',curr);
    sldX_Callback(handles.sldX,1,handles)
else
    set(handles.txtX,'String',num2str(get(handles.sldX,'Value')))
end

% Hints: get(hObject,'String') returns contents of txtX as text
%        str2double(get(hObject,'String')) returns contents of txtX as a double


% --- Executes during object creation, after setting all properties.
function txtX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
