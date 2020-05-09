pkg load image;

% Animacion de las imagenes filtradas
for i = 1:size(r_vec)(2)
  % Plot de la imagen con ruido
  subplot(1, 2, 1);
  imshow(A);
  title('Imagen con ruido');
  
  % Plot de la imagen filtrada
  subplot(1, 2, 2);
  imshow(im_filtradas(:, :, :, i));
  title(['Imagen Filtrada r = ' num2str(r_vec(i))]);

  % Pausa de 0.5 segundos
  pause(0.5)
endfor
%}

%{
% Dimension original de la imagen
m = 64; n = 64;

% Numero de la imagen
num = 150;

% Lectura de la imagen y conversion a formato double
A = imread(['ruido/sat_ruido' num2str(num) '.jpg']);
A = im2double(A);

% Plot de la Imagen Original
subplot(1, 3, 1);
imshow(A);
title('Imagen con ruido');

% Se vertoriza la imagen cargada
A = [A(:)];

% Se filtra la imagen y se restaura su tamaño
X = Z * A;
X = reshape(X, [m ,n]);

% imshow(X);
% imwrite(X,'filtrada.jpg');

% Plot de la imagen sin ruido
subplot(1, 3, 2);
imshow(imread(['original/sat_original' num2str(num) '.jpg']));
title('Imagen Original');

% Plot de la Imagen Filtrada
subplot(1, 3, 3);
imshow(X);
title('Imagen Filtrada');
%}
