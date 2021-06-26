function varargout = kuis_SAW(varargin)
% KUIS_SAW MATLAB code for kuis_SAW.fig
%      KUIS_SAW, by itself, creates a new KUIS_SAW or raises the existing
%      singleton*.
%
%      H = KUIS_SAW returns the handle to a new KUIS_SAW or the handle to
%      the existing singleton*.
%
%      KUIS_SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KUIS_SAW.M with the given input arguments.
%
%      KUIS_SAW('Property','Value',...) creates a new KUIS_SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kuis_SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kuis_SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kuis_SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 08:10:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kuis_SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @kuis_SAW_OutputFcn, ...
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


% --- Executes just before kuis_SAW is made visible.
function kuis_SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kuis_SAW (see VARARGIN)

% Choose default command line output for kuis_SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kuis_SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kuis_SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi data
opts.SelectedVariableNames = (1); %untuk mengambil data kolom 1
data1 = readmatrix('DATA RUMAH.xlsx',opts); %untuk menyimpan data diatas ke data1

opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi data
opts.SelectedVariableNames = (3:8); %untuk mengambil data kolom 3 sampai 8
data2 = readmatrix('DATA RUMAH.xlsx',opts);%untuk menyimpan data diatas ke data2

data = [data1 data2]; %menyimpan data1 dan data2 sebagai matriks di data
set(handles.uitable1,'data',data); %menampilkan data ke dalam table pada GUI

opts = detectImportOptions('DATA RUMAH.xlsx'); %untuk mendeteksi data
opts.SelectedVariableNames = (3:8); %untuk mengambil data kolom 3 sampai 8
x = readmatrix('DATA RUMAH.xlsx',opts); %menyimpan data yang telah diambil ke dalam x
k = [0,1,1,1,1,1]; %atribut tiap-tiap kriteria, dimana nilai 1=atrribut keuntungan, dan  0= atribut biaya
w = [0.30,0.20,0.23,0.10,0.07,0.10]; %nilai bobot tiap kriteria

[m n] = size(x); %menentukan besar matriks x kemudian disimpan ke dalam matrik [m x n]
R = zeros (m,n); %membuat matriks kosong R yang ukurannya seperti matriks [m x n]
%tahapan normalisasi matriks
for j=1:n,
    if k(j)==1,
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%proses perangkingan 
for i=1:m,
    V(i) = sum(w.*R(i,:));
end;

Vtranspose = V.';
Vtranspose = num2cell(Vtranspose);
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = (2);
x2 = readtable('DATA RUMAH.xlsx',opts);
x2 = table2cell(x2);
x2 = [x2 Vtranspose];
x2 = sortrows(x2,-2);
x2 = x2(1:20,1);

set(handles.uitable2,'data',x2); %menampilkan data ke dalam table pada GUI
