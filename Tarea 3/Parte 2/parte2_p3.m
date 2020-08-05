clc; clear; close all;
pkg load image;
% Carga de las imagenes originales
A = imread('fondo_verde.jpg');
A = im2double(A);
B = imread('playa.jpg');
B = im2double(B); 
C = B; % Se copia la imagen que tiene el fondo

% Se crea una matriz binaria, una posicion es 1 si corresponde
% a un fondo verde, cero en caso contrario
R = (A(:,:,1) <= 0.15) & (A(:,:,2) >= 0.8) & (A(:,:,3) <= 0.15);
R3 = cat(3,R,R,R);

% Se invierte la logica, su valor es 1 si el fondo no es verde
R = ~R;
R3 = ~R3;

% Se agrega al sujeto en el fondo de la playa
% La imagen C es una copia del fondo, mientras que R3 es una matriz binaria
% que tiene 1 en aquellos pixeles que pertenecen a la imagen del sujero
% Aquellos pixeles pertenecientes al sujeto son sobreescritos en el fondo cond
% la informacion del sujeto
C(R3) = A(R3);

subplot(2,2,1);
imshow(C);
title('(a) Imagen con borde verde')

% Calculo del borde de la imagen binaria R
% Elemento estructurado
SE = strel('diamond',2);

% Gradiente morfologico: (A dilatacion B) - (A erosion B)
borde = R&~imerode(R,SE);

% Creacion del kernel
a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];
% Eliminacion del borde verde
iter = 7;
Cr = inpainting(C(:,:,1),borde,kernel1,iter);
Cv = inpainting(C(:,:,2),borde,kernel1,iter);
Cb = inpainting(C(:,:,3),borde,kernel1,iter);
C = cat(3, Cr, Cv, Cb);

% Grafica
subplot(2,2,2);
imshow(im2uint8(borde));
title('(b) Contorno');

subplot(2,2,3);
imshow(C);
title('(c) Imagen modificada');
