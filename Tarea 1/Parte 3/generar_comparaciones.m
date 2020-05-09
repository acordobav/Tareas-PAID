total_comparaciones = 40;

imCargadas = zeros(112, 92, 1, total_comparaciones);
imCoincidencia = zeros(112, 92, 1, total_comparaciones);

for j = 1:total_comparaciones
  % Lectura de la imagen
  imagen = im2double(imread(['Comparar\' num2str(j) '_10.png']));
  imCargadas(:, :, :, j) = imagen;
  
  imagen = imagen(:); % Se vectoriza la imagen

  x1 = U(:, 1:r)' * (imagen - f); % Se calcula el vector coordenado
  fp = U(:, 1:r) * x1; % Se calcula el vector de proyeccion
  ef = norm((imagen - f) - fp); % Se calcula la distancia al espacio de caras

  e = [];
  [m, n] = size(x);
  % Se realiza la comparacion con cada imagen del espacio de caras
  for i = 1:n 
    x_i = x(:, i); % Distancia al espacio de caras de la imagen "i" 
    e_i = norm(x1 - x_i); % Se utiliza la norma para comparar
    e = [e e_i]; % Se almacena el resultado de la comparacion
  endfor  
  
  % Se obtiene la imagen que tuvo la mayor similitud con la cara ingresada
  % Se busca el resultado que tenga la menor norma
  [val, pos] = min(e);
  B = reshape(S(:, pos), [112 92]); % Se restauran las dimensiones de la imagen
  
  imCoincidencia(:, :, :, j) = B; % Se almacena la coincidencia
endfor


for i = 1:total_comparaciones
  f=figure(2);
  set(f,'Visible', 'off');
  
  % Plot del rostro ingresado
  subplot(1, 2, 1);
  
  imagen = imCargadas(:, :, :, i);
  imshow(imagen);
  title('Imagen ingresada');
  
  % Plot de la coincidencia obtenida
  subplot(1, 2, 2);
  coincidencia = imCoincidencia(:, :, :, i);
  imshow(coincidencia);
  title('Coincidencia');
  
  % Se almacena la imagen
  saveas(f,['comparaciones/' num2str(i) '.png']);
  close(f);
endfor
