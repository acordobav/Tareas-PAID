clc; clear; close all;
% Carga de las imagenes originales
A = imread('fondo_verde.jpg');
B = imread('playa.jpg'); 
C = B; % Se copia la imagen que tiene el fondo

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
%borde = im2uint8(imdilate(R,SE)&~imerode(R,SE));
borde = im2uint8(R&~imerode(R,SE));

% Creacion del kernel
a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];
% Eliminacion del borde verde
C = inpainting(C,borde,kernel1,5);

% Grafica
subplot(1,2,1);
imshow(im2uint8(borde));
title('(a) Contorno');

subplot(1,2,2);
imshow(C);
title('(b) Imagen modificada');
