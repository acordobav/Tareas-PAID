clc; clear; close all;
% Carga de las imagenes originales
A = imread('fondo_verde.jpg');
B = imread('playa.jpg'); 
C = B; % Se copia la imagen que tiene fondo

% Se crea una matriz binaria, una posicion es 1 si corresponde
% a un fondo verde, cero en caso contrario
R = (A(:,:,1) <= 40) & (A(:,:,2) >= 200) & (A(:,:,3) <= 40);
R = cat(3,R,R,R);

% Se invierte la logica, su valor es 1 si el fondo no es verde
R = ~R;

% Se sobreescribe C en aquellas posiciones en 
% las que la imagen A no es un fondo verde
C(R) = A(R);

% Grafica
subplot(2,2,1);
imshow(A);
title('(a) Imagen con fondo verde');

subplot(2,2,2);
imshow(B);
title('(b) Fondo para nueva imagen');

subplot(2,2,3);
imshow(im2double(R));
title('(c) Matriz binaria');

subplot(2,2,4);
imshow(C)
title('(d) Imagen modificada');