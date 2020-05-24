clc; clear;

% Este archivo genera el "espacio de caras" utilizado para comparar

total_per = 40; % Total de personas
S = []; % Training set

% Carga de las imagenes
for i = 1:total_per
  % Por cada persona se tienen nueve imagenes
  filename_i = ['Database\' num2str(i) '_'];
  for j = 1:9
      filename_j = [filename_i num2str(j) '.png'];
      f_i = im2double(imread(filename_j));
      S = [S f_i(:)]; % Se agrega la imagen en forma vectorial
  endfor
endfor

% Se calcula la cara promedio del training set
total_im = size(S)(2); % Total de imagenes 
f = 0; # Variable para guardar la sumatoria de las imagenes
for i = 1:total_im
  f_i = S(:, i); # Se obtiene la imagen "i"
  f = f + f_i;
endfor
f = f/total_im; # Se obtiene el promedio

% Construccion de la matriz A, cada una de las columnas es una imagen
% a la que se le ha restado la cara promedio
A = zeros(size(S));
for i = 1:total_im
  f_i = S(:, i); # Se obtiene la imagen "i"
  A(:, i) = f_i - f; # Se realiza la resta de la cara promedio
endfor

% Descomposicion de la matriz A en valores singulares
[U, S_A, V] = svd(A);

% Se calcula un vector "x" para cada imagen, este vector representa la
% posicion de cada cara en el espacio de caras
r = rank(A);
x = zeros([r total_im]);
for i = 1:total_im
  x_i = U(:, 1:r)' * A(:, i);
  x(:, i) = x_i;
endfor

el = 10; % Maxima distancia en el espacio de caras
e0 = 3.8780; % Maxima distancia de cualquier cara conocida en el espacio