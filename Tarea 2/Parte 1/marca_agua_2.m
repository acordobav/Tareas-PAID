clc; clear; close all;
pkg load signal;

U1 = load('U1.mat').U1;
V1 = load('V1.mat').V1;

I = imread('imagen2.jpg');
I = im2double(I);
I_o = imread('imagen3.jpg');
I_o = im2double(I_o);
subplot(1,2,1);
imshow(I);
title('Imagen con ruido y marca de agua');

% Se divide la imagen modificada en bloques de 4x4 y se les aplica
% la DCT-2D para obtener el valor DC de cada bloque
Aw = zeros(256,256);
A = zeros(256,256);
for i = 1:256
  i_fin = 4*i;
  i_ini = i_fin - 3;
  for j = 1:256
    j_fin = j*4;
    j_ini = j_fin-3;
    Aw(i,j) = dct2(I(i_ini:i_fin,j_ini:j_fin))(1,1);
    A(i,j) = dct2(I_o(i_ini:i_fin,j_ini:j_fin))(1,1);
  endfor
endfor

% Descomposicion en valores singulares de Aw y A
[Uw,Sw,Vw] = svd(Aw);
[U,S,V] = svd(A);

% Reconstruccion de la marca de agua
alpha = 0.1;
D = U1 * Sw * V1';
W = (1/alpha)*(D - S);

subplot(1,2,2);
imshow(W);
title('Marca de agua extraida');