% Metodo del Indice de Similitud Estructural SSIM
clc; clear; close all
pkg load image
pkg load video

% Cargar el video original
VL = VideoReader('video_limpio.mp4');
frames = VL.NumberOfFrames;

% Cargar el video sin ruido 1
VSR1 = VideoReader('video_sin_ruido_1.mp4');

% Cargar el video sin ruido 2
VSR2 = VideoReader('video_sin_ruido_2.mp4');

% Vectores donde se almacenan los indices de similitud por color de canal
VR1(1:frames) = 0;
VV1(1:frames) = 0;
VA1(1:frames) = 0;
VR2(1:frames) = 0;
VV2(1:frames) = 0;
VA2(1:frames) = 0;

%Leer los videos
for k = 1:frames
   Z1 = readFrame(VL); %Leer cada uno de los marcos del video limpio
   Z2 = readFrame(VSR1); %Leer cada uno de los marcos del video sin ruido 1
   Z3 = readFrame(VSR2); %Leer cada unos de los marcos del video sin ruido 2
   
   % Indices de similitud para el video sin ruido 1
   VR1(k) = ssim(Z1(:,:,1), Z2(:,:,1)); %Informacion Canal Rojo
   VV1(k) = ssim(Z1(:,:,2), Z2(:,:,2)); %Informacion Canal Verde
   VA1(k) = ssim(Z1(:,:,3), Z2(:,:,3)); %Informacion Canal Azul
  
   % Indices de similitud para el video sin ruido 2
   VR2(k) = ssim(Z1(:,:,1), Z3(:,:,1)); %Informacion Canal Rojo
   VV2(k) = ssim(Z1(:,:,2), Z3(:,:,2)); %Informacion Canal Verde
   VA2(k) = ssim(Z1(:,:,3), Z3(:,:,3)); %Informacion Canal Azul
endfor

SSIMR1 = mean(VR1);
SSIMV1 = mean(VV1);
SSIMA1 = mean(VA1);
SSIMR2 = mean(VR2);
SSIMV2 = mean(VV2);
SSIMA2 = mean(VA2);

SSIM1 = (SSIMR1 + SSIMV1 + SSIMA1) / 3;
SSIM1
SSIM2 = (SSIMR2 + SSIMV2 + SSIMA2) / 3;
SSIM2