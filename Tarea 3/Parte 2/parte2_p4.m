clc; clear; close all;
pkg load image;
pkg load video;
tic
% Objetos que contienen la informacion de los videos
VA = VideoReader('video_avion.mp4'); % Comando para cargar un video
VC = VideoReader('video_cielo.mp4'); % Comando para cargar un video

fr = VA.NumberOfFrames; % Numero de Marcos
m = VA.Height; % Numero de filas de cada marco
n = VA.Width; % Numero de columnas de cada marco

% Matriz donde se van a guardar los nuevos marcos redimensionados
Y1 = uint8(zeros(m, n, 3, fr)); % Video avion
Y2 = uint8(zeros(m, n, 3, fr)); % Video cielo

% Leer los videos y guardar cada uno de los marcos
for k = 1:fr
  Y1(:,:,:,k) = readFrame(VA); % Leer cada marco del video
  Y2(:,:,:,k) = readFrame(VC); % Leer cada marco del video
endfor

Y1 = im2double(Y1);
Y2 = im2double(Y2);

% Creacion del kernel para la restauracion
a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];

% Elemento estructurado
SE = strel('diamond',3);

% Se aplica el algoritmo croma en cada marco de los videos
for k = 1:fr
  A = Y1(:,:,:,k); % Se obtiene un frame del avion
  C = Y2(:,:,:,k); % Se obtiene un frame del cielo
  
  % Se crea una matriz binaria, una posicion es 1 si corresponde
  % a un fondo verde, cero en caso contrario
  R = (A(:,:,1) <= 0.15) & (A(:,:,2) >= 0.8) & (A(:,:,3) <= 0.15);
  R3 = cat(3,R,R,R);

  % Se invierte la logica, su valor es 1 si el fondo no es verde
  R = ~R;
  R3 = ~R3;
  
  % Se sobreescribe C en aquellas posiciones en 
  % las que la imagen A no es un fondo verde
  C(R3) = A(R3);
  
  % Calculo del borde de la imagen binaria R
  % Gradiente morfoligico: (A dilatacion B) - (A erosion B)
  borde = R&~imerode(R,SE);
    
  % Eliminacion del borde verde
  iter = 15;
  Cr = inpainting(C(:,:,1),borde,kernel1,iter);
  Cv = inpainting(C(:,:,2),borde,kernel1,iter);
  Cb = inpainting(C(:,:,3),borde,kernel1,iter);
  C = cat(3, Cr, Cv, Cb);
  
  % Se almacena la imagen modificada
  Y2(:,:,:,k) = C;
endfor  

% Crear el nuevo video
Y2 = im2uint8(Y2);
video = VideoWriter('video_croma.mp4'); % Crear el video nuevo (vacio)
for i = 1:fr
  writeVideo(video, Y2(:, :, :, i)); % Agregar cada marco del video
endfor
close(video);
t = toc