% Este archivo utiliza el espacio de caras generado por face_space.m para
% realizar una comparacion entre una cara ingresada con las almacenadas
% en el espacio de caras

% Lectura de la imagen
imagen = imread('Comparar\17_10.png');
imagen = im2double(imagen)(:);

x1 = U(:, 1:r)' * (imagen - f); % Se calcula el vector coordenado
fp = U(:, 1:r) * x1; % Se calcula el vector de proyeccion
ef = norm((imagen - f) - fp); % Se calcula la distancia al espacio de caras

% Si ef > el la imagen ingresada no es una cara
if ef > el
  Y = 0; % Y = 0 significa que no es una cara
  B = 0;
else % Si ef < el la imagenes es una cara  
  Y = 1; % Y = 1 significa que es una cara
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
endif  

imshow(B);

