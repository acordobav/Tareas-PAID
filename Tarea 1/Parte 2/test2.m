clc; clear;

% Dimensiones de las imagenes
m = 64; n = 64;

% Total de imagenes
total_im = 416;

% Calculo del r para cada reconstruccion
r = 416;

% Se cargan las imagenes originales y con ruido
C = []; % Vector con las imagenes sin ruido 
B = []; % Vector con las imagenes con ruido
for i = 1:total_im
  % Lectura de los archivos y conversion a formato double
  x_i = im2double(imread(['original\sat_original' num2str(i) '.jpg']));
  b_i = im2double(imread(['ruido\sat_ruido' num2str(i) '.jpg']));
  % Se agregan las versiones vectorizadas a las matrices
  B = [B b_i(:)]; 
  C = [C x_i(:)];
endfor

% Descomposicion de B en valores singulares
[Ub, Sb, Vb] = svd(B);

%------   Filtrado de la imagen con ruido   ------%
% Lectura de la imagen y conversion a formato double
A = imread('limpiar.jpg');
A = im2double(A);
A_vec = [A(:)]; % Se vertoriza la imagen cargada


% Calculo de Z
s = rank(B);
Vs = Vb(:, 1:s);

P = C * Vs * Vs';

[Up, Sp, Vp] = svd(P);

Pr = Up(:, 1:r) * Sp(1:r, 1:r) * Vp(:, 1:r)';

Z = Pr * pinv(B);

% Se filtra la imagen y se restauran sus dimensiones
X = Z * A_vec;
X = reshape(X, [m ,n]);

imshow(X);
  