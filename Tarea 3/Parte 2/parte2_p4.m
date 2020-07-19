clc; clear; close all;
pkg load video
tic
% Carga de las imagenes originales
A = imread('fondo_verde.jpg');
B = imread('playa.jpg'); 
C = B; % Se copia la imagen que tiene fondo

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
  Y1(:,:,:,k) = readFrame(VA); % Leer cada uno de los marcos del video
  Y2(:,:,:,k) = readFrame(VC); % Leer cada uno de los marcos del video
endfor

% Creacion del kernel para la restauracion
a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];

for k = 1:fr
  A = Y1(:,:,:,k); % Se obtiene un frame del avion
  C = Y2(:,:,:,k); % Se obtiene un frame del cielo
  
  % Se crea una matriz binaria, una posicion es 1 si corresponde
  % a un fondo verde, cero en caso contrario
  R = (A(:,:,1) <= 40) & (A(:,:,2) >= 200) & (A(:,:,3) <= 40);
  R = cat(3,R,R,R);

  % Se invierte la logica, su valor es 1 si el fondo no es verde
  R = ~R;
  
  % Se sobreescribe C en aquellas posiciones en 
  % las que la imagen A no es un fondo verde
  C(R) = A(R);
  
  % Calculo del borde de la imagen binaria R
  % Elemento estructurado
  SE = strel('diamond',2);

  % Gradiente morfoligico: (A dilatacion B) - (A erosion B)
  borde = im2uint8(R&~imerode(R,SE));
    
  % Eliminacion del borde verde
  C = inpainting(C,borde,kernel1,5);
  
  % Se almacena la imagen modificada
  Y2(:,:,:,k) = C; 
endfor  

% Crear el nuevo video
video = VideoWriter('video_salida.mp4'); % Crear el video nuevo (vacio)
for i = 1:fr
  writeVideo(video, Y2(:, :, :, i)); % Agregar cada marco del video
endfor
close(video);
t = toc