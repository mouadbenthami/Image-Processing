function varargout = phtotoEditor(varargin)
% PHTOTOEDITOR MATLAB code for phtotoEditor.fig
%      PHTOTOEDITOR, by itself, creates a new PHTOTOEDITOR or raises the existing
%      singleton*.
%
%      H = PHTOTOEDITOR returns the handle to a new PHTOTOEDITOR or the handle to
%      the existing singleton*.
%
%      PHTOTOEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PHTOTOEDITOR.M with the given input arguments.
%
%      PHTOTOEDITOR('Property','Value',...) creates a new PHTOTOEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before phtotoEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to phtotoEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help phtotoEditor

% Last Modified by GUIDE v2.5 31-Jan-2023 01:03:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @phtotoEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @phtotoEditor_OutputFcn, ...
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


% --- Executes just before phtotoEditor is made visible.
function phtotoEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to phtotoEditor (see VARARGIN)

% Choose default command line output for phtotoEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes phtotoEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = phtotoEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_Callback(hObject, eventdata, handles)
[path,nofile]=imgetfile();
if nofile
    msgbox(sprintf('not found','Error','Warning'));
    return
end
stack={};
im1=imread(path);
stack{end+1}=im1;
axes(handles.axes1);
setappdata(0,'stack',stack);
setappdata(0,'org',im1);
imshow(im1);

    %%imhist(im1);
    if strcmp(get(handles.axes2, 'Visible'), 'on')
        axes(handles.axes2);
        imhist(im1); 
    end    
    %%
    %%imhist(im1,'Parent',handles.axes2);
%hist_data = imhist(im1);
%bar(hist_data,'Parent',handles.axes2);

set(handles.edit,'enable','on');
set(handles.noise,'enable','on');
set(handles.save,'enable','on');
set(handles.close,'enable','on');
set(handles.filter,'enable','on');
set(handles.rotation,'enable','on');
set(handles.Untitled_3,'enable','on');
set(handles.compresse,'enable','on');
set(handles.Transformation,'enable','on');
set(handles.contours,'enable','on');
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
%stack=getappdata(0,'stack');
%im=stack{end};
%imwrite(im,'image_Transformed_.png');

    % Get the current image data
    stack=getappdata(0,'stack');
    res=stack{end};
    % Open the file explorer to choose a save location
    [file, path] = uiputfile('*.png', 'Save Image');
    % If the user selected a file, save the image data
    if file ~= 0
        imwrite(res, fullfile(path, file));
    end
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function redo_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
im=stack{end-1};
stack{end-1}=stack{end};
stack{end}=im;
setappdata(0,'stack',stack);
axes(handles.axes1);
imshow(im);
 
 if strcmp(get(handles.axes2, 'Visible'), 'on')
        axes(handles.axes2);
        imhist(im);
 end  
 
 
% hObject    handle to redo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function undo_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
im=stack{end-1};
stack{end-1}=stack{end};
stack{end}=im;
setappdata(0,'stack',stack);
axes(handles.axes1);
imshow(im);
 
 if strcmp(get(handles.axes2, 'Visible'), 'on')
     axes(handles.axes2);
       imhist(im);
 end 
set(handles.redo,'enable','on');
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
cla(handles.axes1);
set(handles.edit,'enable','off');
set(handles.noise,'enable','off');
set(handles.save,'enable','off');
set(handles.close,'enable','off');
set(handles.Transformation,'enable','off');
set(handles.redo,'enable','off');
set(handles.undo,'enable','off');
set(handles.reset,'enable','off');
set(handles.filter,'enable','off');
set(handles.axes2, 'Visible', 'off');
set(handles.rotation,'enable','off');
set(handles.Untitled_3,'enable','off');
set(get(handles.axes2, 'Children'), 'Visible', 'off');
set(handles.compresse,'enable','off');
set(handles.slider1,'Visible','off');
set(handles.done  ,'Visible','off');
set(handles.contours,'enable','off');
stripes = findall(gcf, 'Tag', 'colorstripe');
    delete(stripes);
    set(handles.axes2,'Visible','off');
    set(get(handles.axes2, 'Children'), 'Visible', 'off');
    set(handles.hist, 'Label', 'Show histogram');
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function reset_Callback(hObject, eventdata, handles)
im=getappdata(0,'org');

%stack{end}=im;
%setappdata(0,'stack',stack);
axes(handles.axes1);
imshow(im);
 
   if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(im); 
   end 
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function noise_Callback(hObject, eventdata, handles)
% hObject    handle to noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gussian_Callback(hObject, eventdata, handles)
%{
    prompt={'Entre variance value :'};
    dims=[1 50];
    dlgtitle='Input';
    definput={'0'};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    a=str2num(answer{1});
   stack=getappdata(0,'stack');
   img=stack{end};
   result= imnoise(img,'gaussian',0 ,a);
   axes(handles.axes1);
   imshow(result);
 stack = getappdata(0, 'stack');
  stack{end+1}=result;
setappdata(0, 'stack',stack);
 if strcmp(get(handles.axes2, 'Visible'), 'on')
        axes(handles.axes2);
        imhist(result);
 end 
%}
b=3;
setappdata(0,'b',b);
set(handles.slider1, 'Min', 0);
set(handles.slider1, 'Max', 0.1);
set(handles.slider1,'Value',0);
set(handles.slider1, 'Visible', 'on');
set(handles.done, 'Visible', 'on');

 

% hObject    handle to gussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saltApepper_Callback(hObject, eventdata, handles)
%{
    prompt={'Entre  density value :'};
    dims=[1 50];
    dlgtitle='Input';
    definput={'0'};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    a=str2num(answer{1});
   stack=getappdata(0,'stack');
   img=stack{end};
   result= imnoise(img,'salt & pepper' ,a);
   axes(handles.axes1);
   imshow(result);

 if strcmp(get(handles.axes2, 'Visible'), 'on')
     axes(handles.axes2);
     imhist(result);    
 end 
  stack = getappdata(0, 'stack');
  stack{end+1}=result;
setappdata(0, 'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
%}
b=4;
setappdata(0,'b',b);
set(handles.slider1, 'Min', 0);
set(handles.slider1, 'Max', 0.1);
set(handles.slider1,'Value',0);
set(handles.slider1, 'Visible', 'on');
set(handles.done, 'Visible', 'on');
% hObject    handle to saltApepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Transformation_Callback(hObject, eventdata, handles)
% hObject    handle to Transformation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Linear_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
    ma = max(max(img));
    mi = min(max(img));
    res=(img-mi).*(255./(ma-mi));
    axes(handles.axes1);
    imshow(res);
    
     if strcmp(get(handles.axes2, 'Visible'), 'on')
        axes(handles.axes2);
        imhist(res);
     end 

    stack{end+1}=res;
    setappdata(0, 'stack',stack);
    set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to Linear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function LinearSaturation_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
im=stack{end};    
    mi = 80;
    ma = 150;
    res=(im-mi).*(255./(ma-mi));
    axes(handles.axes1);
    imshow(res);
    
     if strcmp(get(handles.axes2, 'Visible'), 'on')
         axes(handles.axes2);
         imhist(res);
     end 
    
  
    stack{end+1}=res;
    setappdata(0, 'stack',stack);
    set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to LinearSaturation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function NegativeImage_Callback(hObject, eventdata, handles)
    stack=getappdata(0,'stack');
    im=stack{end};       
    res = 255 - im;
    axes(handles.axes1);
    imshow(res);
    
    if strcmp(get(handles.axes2, 'Visible'), 'on')
        axes(handles.axes2);
        imhist(res);
    end 
    stack{end+1}=res;
    setappdata(0,'stack',stack);
    set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to NegativeImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function egalisation_Callback(hObject, eventdata, handles)
    stack=getappdata(0,'stack');
    im=stack{end}; 
    res= histeq(im);
    axes(handles.axes1);
    imshow(res);
    
     if strcmp(get(handles.axes2, 'Visible'), 'on')
         axes(handles.axes2);
         imhist(res);
     end 
    stack{end+1}=res;
    setappdata(0,'stack',stack);
    set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to egalisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function binarization_Callback(hObject, eventdata, handles)
    prompt={'Entre value :'};
    dims=[1 50];
    dlgtitle='Input';
    definput={'0'};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    d=str2num(answer{1});
    stack=getappdata(0,'stack');
    im=stack{end}; 
    res=im2bw(im,d/256);
    axes(handles.axes1);
    imshow(res);

     if strcmp(get(handles.axes2, 'Visible'), 'on')
          axes(handles.axes2);
         imhist(res);

     end 

    stack{end+1}=res;
    setappdata(0,'stack',stack);
    set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to binarization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------


% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function hist_Callback(hObject, eventdata, handles)
if strcmp(get(handles.axes2, 'Visible'), 'on') 
    cla(handles.axes2);  
    set(handles.axes2,'Visible','off');
    set(get(handles.axes2, 'Children'), 'Visible', 'off');
    set(handles.hist, 'Label', 'Show histogram');
    stripes = findall(gcf, 'Tag', 'colorstripe');
    delete(stripes);

    % If the axes are currently hidden, show them
    else
        set(handles.axes2, 'Visible', 'on');
        set(handles.hist, 'Label', 'Hide histogram');
        set(get(handles.axes2, 'Children'), 'Visible', 'on');
        stack=getappdata(0,'stack');
        res=stack{end};
      % Calculate the histogram data
        axes(handles.axes2);
        imhist(res);
% Plot the histogram using the bar function


     
end
% hObject    handle to hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function moyen_Callback(hObject, eventdata, handles)
    prompt={'Entre matrix size :'};
    dims=[1 50];
    dlgtitle='Input';
    definput={'0'};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    d=str2num(answer{1});
    stack=getappdata(0,'stack');
    im=stack{end};
   
    mat=ones(d)/(d*d);
    m=imnoise(im, 'gaussian', 0, 0.03);
    res=imfilter(m, mat);
    axes(handles.axes1);
    imshow(res);
    stack{end+1}=res;
    setappdata(0,'stack',stack);

    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(res);
    end 
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to moyen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function median_Callback(hObject, eventdata, handles)
    stack=getappdata(0,'stack');
    im=stack{end};
    img_noisy=imnoise(im,'salt & pepper',0.02);
    res=img_noisy;
    for c = 1 : 3
    res(:, :, c) = medfilt2(img_noisy(:, :, c), [3, 3]);
    end
    axes(handles.axes1);
    imshow(res);
     stack{end+1}=res;
    setappdata(0,'stack',stack);

    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(res);
    end 
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gausianfilter_Callback(hObject, eventdata, handles)
    prompt={'Entre Sigma value :'};
    dims=[1 50];
    dlgtitle='Input';
    definput={'0'};
    answer=inputdlg(prompt,dlgtitle,dims,definput);
    d=str2num(answer{1});
    stack=getappdata(0,'stack');
    im=stack{end};
    res=imgaussfilt(im,d);
    axes(handles.axes1);
    imshow(res);
     stack{end+1}=res;
    setappdata(0,'stack',stack);

    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(res);
    end 
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to gausianfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function convolution_Callback(hObject, eventdata, handles)
    kernelSize = inputdlg('Enter kernel size (e.g. 3 for a 3x3 kernel):');
    kernelSize = str2double(kernelSize{1});

    % Prompt user for kernel values
    kernelValues = inputdlg(sprintf('Enter %d values for kernel separated by space:', kernelSize^2));
    kernelValues = str2num(kernelValues{1});
    
    % Initialize the kernel
    kernel = reshape(kernelValues, [kernelSize, kernelSize]);


    stack=getappdata(0,'stack');
    image=stack{end};
    conv_image = convn(image, kernel, 'same');
    axes(handles.axes1);
    imshow(conv_image);
    stack{end+1}=conv_image;
    setappdata(0,'stack',stack);

    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(conv_image);
    end 
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
   


% hObject    handle to convolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in done.
function done_Callback(hObject, eventdata,handles)
img = getimage(handles.axes1);
stack=getappdata(0,'stack');
stack{end+1}=img;
setappdata(0,'stack',stack);
axes(handles.axes1);
imshow(img);
if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
end 
set(handles.slider1, 'Visible', 'off');
set(handles.done, 'Visible', 'off');
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

stack=getappdata(0,'stack');
img=stack{end};
b=getappdata(0,'b');
if(b==1)
   
    angle= get (hObject, 'Value');
   img = imrotate(img, angle, 'bicubic', 'crop');
   
elseif(b==0)
 
    angle= get (hObject, 'Value');
   img=img+angle;
   
elseif(b==2)
    
    angle= get (hObject, 'Value');
    angle=floor(angle);
    ag=fspecial('average',[angle,angle]);
    img=imfilter(img,ag);
elseif(b==3)
     angle= get (hObject, 'Value');
     img= imnoise(img,'gaussian',0 ,angle);
elseif(b==4)
    angle= get (hObject, 'Value');
    img= imnoise(img,'salt & pepper' ,angle);
end
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
function rotation_Callback(hObject, eventdata, handles)
% hObject    handle to rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rotateSlider_Callback(hObject, eventdata, handles)
b=1;
setappdata(0,'b',b);
set(handles.slider1, 'Min', 0);
set(handles.slider1, 'Max', 360);
set(handles.slider1,'Value',0);
set(handles.slider1, 'Visible', 'on');
set(handles.done, 'Visible', 'on');
% hObject    handle to rotateSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function right_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img = imrotate(img, 90, 'bicubic', 'crop');
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function left_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img = imrotate(img, -90, 'bicubic', 'crop');
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function flip_Callback(hObject, eventdata, handles)
% hObject    handle to flip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function flipH_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img = fliplr(img);
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to flipH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function flipV_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img = flipud(img);
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to flipV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function red_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img(:,:,2:3)=0;
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img(:,:,1)=0;
img(:,:,3)=0;
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img(:,:,1)=0;
img(:,:,2)=0;
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)

stack=getappdata(0,'stack');
img=stack{end};
img = rgb2gray(img);
axes(handles.axes1);
imshow(img);

    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');


% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bandw_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
img = im2bw(img,.57);
axes(handles.axes1);
imshow(img);


    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
    end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to bandw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function brightness_Callback(hObject, eventdata, handles)
b=0;
setappdata(0,'b',b);
set(handles.slider1, 'Min', 0);
set(handles.slider1, 'Max', 255);
set(handles.slider1,'Value',0);
set(handles.slider1, 'Visible', 'on');
set(handles.done, 'Visible', 'on');
% hObject    handle to brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function compressed_Callback(hObject, eventdata, handles)
% hObject    handle to compressed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function compresse_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};


    % Open the file explorer to choose a save location
    [file, path] = uiputfile('compressed_image.jpg', 'Save Image');
    % If the user selected a file, save the image data
    if file ~= 0
        imwrite(img,fullfile(path, file), 'Quality', 50);
    end
% Encode quantized DCT coefficients using JPEG

% hObject    handle to compresse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function blurall_Callback(hObject, eventdata, handles)
b=2;
setappdata(0,'b',b);
set(handles.slider1, 'Min', 3);
set(handles.slider1, 'Max', 20);
set(handles.slider1,'Value',3);
set(handles.slider1, 'Visible', 'on');
set(handles.done, 'Visible', 'on');
% hObject    handle to blurall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function blurpart_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
a=stack{end};

[j, rect]=imcrop(a);
ag=fspecial('average',[9,9]);
g=imfilter(a,ag);
g( rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3), :)=j;
axes(handles.axes1);
imshow(g);
    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(g);
    end 
    stack{end+1}=g;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to blurpart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function more_Callback(hObject, eventdata, handles)
% hObject    handle to more (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------

% hObject    handle to cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to more (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cropimage_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
a=stack{end};

[g, rect]=imcrop(a);

%g( rect(2):rect(2)+rect(4),rect(1):rect(1)+rect(3), :)=j;

axes(handles.axes1);
imshow(g);
    if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(g);
    end 
    stack{end+1}=g;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to cropimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function info_Callback(hObject, eventdata, handles)
% Read in the image file
stack=getappdata(0,'stack');
img=stack{end};
imwrite(img,'img.png')
% Get the image information
info = imfinfo('img.png');

% Create a string with the image information
imageData = sprintf('Image size: %d x %d\nImage type: %s\nImage size in bytes: %d', info.Width, info.Height, info.Format,info.FileSize);

% Prompt the user to select a location to save the text file
[file, path] = uiputfile('*.txt', 'Save Image Information As');

% Write the image information to the text file
fid = fopen(fullfile(path, file), 'w');
fprintf(fid, '%s', imageData);
fclose(fid);
% hObject    handle to info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------


% hObject    handle to write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};

% Prompt the user to select a location to write the text
[x, y] = ginput(1);

% Prompt the user for the text to write on the image
textToWrite = inputdlg('Enter text to write on image:');

% Write the text on the image
%text(x, y, textToWrite, 'Color', 'red', 'FontSize', 14);
img= insertText(img, [x y ], textToWrite, 'FontSize', 14, 'BoxColor', 'black', 'TextColor', 'white');
% Show the image with the text
imshow(img);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(img);
  end 
    stack{end+1}=img;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Sinusoidal_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
img=stack{end};
% Get the size of the image
[rows, cols, channels] = size(img);

% Generate the sinusoidal noise
frequency = 0.1;
phase = 0;
noise = sin(2 * pi * frequency * (1:cols) + phase);
noise = repmat(noise, rows, 1, channels);
% Add the noise to the image
resul= img + uint8(noise * 128);
imshow(resul);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(resul);
  end 
 stack{end+1}=resul;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');
% hObject    handle to Sinusoidal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function contours_Callback(hObject, eventdata, handles)
% hObject    handle to contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Sobel_Callback(hObject, eventdata, handles)
% hObject    handle to Sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack=getappdata(0,'stack');
current=stack{end};
current=im2gray(current);
current = edge(current,'sobel');
axes(handles.axes1);
imshow(current);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(current);
  end 
stack{end+1}=current;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');


% --------------------------------------------------------------------
function Prewit_Callback(hObject, eventdata, handles)
% hObject    handle to Prewit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack=getappdata(0,'stack');
current=stack{end};
I=im2gray(current);
ed2= edge(I,'prewitt');
axes(handles.axes1); 
imshow(ed2);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(ed2);
  end 
stack{end+1}=ed2;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');



% --------------------------------------------------------------------
function Roberts_Callback(hObject, eventdata, handles)
% hObject    handle to Roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack=getappdata(0,'stack');
current=stack{end};
current=im2gray(current);
current = edge(current,'roberts');
axes(handles.axes1);
imshow(current);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(current);
  end 
stack{end+1}=current;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');


% --------------------------------------------------------------------
function Zerocross_Callback(hObject, eventdata, handles)
% hObject    handle to Zerocross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack=getappdata(0,'stack');
current=stack{end};
current=im2gray(current);
current = edge(current,'zerocross');
axes(handles.axes1);
imshow(current);
  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(current);
  end 
stack{end+1}=current;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');

% --------------------------------------------------------------------
function ErosionCube_Callback(hObject, eventdata, handles)
% hObject    handle to ErosionCube (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stack=getappdata(0,'stack');
current=stack{end};


st1=[1 1 1 
     1 1 1
     1 1 1];
current= imerode(current,st1);
axes(handles.axes1);
imshow(current);

  if strcmp(get(handles.axes2, 'Visible'), 'on')
       axes(handles.axes2);
       imhist(current);
  end 
stack{end+1}=current;
setappdata(0,'stack',stack);
set(handles.undo,'enable','on');
set(handles.reset,'enable','on');


% --------------------------------------------------------------------

% hObject    handle to Roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function faces_Callback(hObject, eventdata, handles)
stack=getappdata(0,'stack');
e=stack{end};
faceDetector = vision.CascadeObjectDetector;
bboxes =step(faceDetector,e);
     if(sum(sum(bboxes))~=0)
         es=imcrop(e,bboxes);
         a=fspecial('average',[20 20]);
         ls=imfilter(es,a);
         e(bboxes(2):bboxes(2)+bboxes(4),bboxes(1):bboxes(1)+bboxes(3),:)=ls;
         %imshowpair(msa,e,'montage');
         %es=[];
         axes(handles.axes1);
         imshow(e);
     else
         axes(handles.axes1);
         imshow(e);
     end
 

% hObject    handle to faces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
