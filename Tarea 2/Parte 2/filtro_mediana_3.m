%Algoritmo IAMFA-I
clc; clear; close all
pkg load image
pkg load video

tic
%Cargar el video con ruido
V = VideoReader('video_con_ruido.mp4');
frames = V.NumberOfFrames; %Numero de marcos
m = V.Height; %Numero de filas de cada marco
n = V.Width; %Numero de columnas de cada marco

%Matriz donde se guardan los marcos del video filtrados
Y = uint8(zeros(m,n,3,frames));

%Leer el video
for k = 1:frames
   Z = readFrame(V); %Leer cada uno de los marcos del video
   Y(:,:,1,k) = iamfa_i(Z(:,:,1)); %Informacion Canal Rojo
   Y(:,:,2,k) = iamfa_i(Z(:,:,2)); %Informacion Canal Verde
   Y(:,:,3,k) = iamfa_i(Z(:,:,3)); %Informacion Canal Azul
endfor

%Crear el nuevo video
video = VideoWriter('video_sin_ruido_2.mp4'); %Crear el video vacio
for i = 1:frames
  writeVideo(video, Y(:,:,:,i)); %Agregarle cada marco al nuevo video
endfor
close(video);
t1 = toc;
