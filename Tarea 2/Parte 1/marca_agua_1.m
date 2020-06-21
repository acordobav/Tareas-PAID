clc; clear; close all;
pkg load signal;

alpha = 0.1;

% Lectura de la imagen original
I = imread('imagen1.jpg');
I = im2double(I);
subplot(1,4,1);
imshow(I);
title('Imagen Original');

% Lectura de la marca de agua
W = imread('marca.jpg');
W = im2double(W);
subplot(1,4,2);
imshow(W);
title('Marca de agua');

% ------------- Incrustacion de la marca de agua W en la imagen I

% Se divide la imagen original en bloques de 8x8 y se les aplica la DCT-2D
Z = zeros(8,8,1,4096); % Matriz para guardar cada bloque
x = 1; % Contador para iterar sobre Z
A = zeros(64,64); % Matriz para almacenar el valor DC de cada bloque
for i = 1:64
  i_fin = 8*i;
  i_ini = i_fin - 7;
  for j = 1:64
    j_fin = j*8;
    j_ini = j_fin-7;
    block = I(i_ini:i_fin,j_ini:j_fin); % Se obtiene un bloque de 8x8
    dct_block = dct2(block); % Se le aplica DCT-2D al bloque
    Z(:,:,:,x) = dct_block;
    A(i,j) = dct_block(1,1);
    x = x+1;
  endfor
endfor

% Calculo de la descomposicion en valores singulares de A
[U,S,V] = svd(A);

% Calculo de la SVD utilizando la matriz S y la marca de agua
Aw_aux = S + (alpha * W);
[U1,S1,V1] = svd(Aw_aux);

% Calculo de Aw
Aw = U * S1 * V';

Iw = zeros(512, 512); % Matriz para guarda la imagen con la marca de agua
x = 1; % Contador para iterar sobre Z
for i = 1:64
  i_fin = 8*i;
  i_ini = i_fin - 7;
  
  for j = 1:64
    j_fin = j*8;
    j_ini = j_fin-7;
    
    F = Z(:,:,:,x); % Se obtiene el bloque
    
    % Cambio del valor DC de cada bloque por el valor correspondiente en Aw
    F(1,1) = Aw(i,j);
    
    % Se calcula la DCT-2D inversa del bloque y se almacena en la nueva imagen
    Iw(i_ini:i_fin,j_ini:j_fin) = idct2(F);
    
    x = x+1;
  endfor
endfor 
subplot(1,4,3);
imshow(Iw);
title('Imagen modificada')


% ------------- Extraccion de la marca de agua W2 de la imagen Iw

% Se divide la imagen modificada en bloques de 8x8 y se les aplica
% la DCT-2D para obtener el valor DC de cada bloque
Aw = zeros(64,64);
for i = 1:64
  i_fin = 8*i;
  i_ini = i_fin - 7;
  for j = 1:64
    j_fin = j*8;
    j_ini = j_fin-7;
    dct_block = dct2(Iw(i_ini:i_fin,j_ini:j_fin)); % DCT2 del bloque 8x8
    Aw(i,j) = dct_block(1,1);    
  endfor
endfor

% Descomposicion en valores singulares de Aw
[Uw,Sw,Vw] = svd(Aw);

D = U1 * Sw * V1';
W2 = (1/alpha)*(D - S);

subplot(1,4,4);
imshow(W2);
title('Marca de agua extraida');