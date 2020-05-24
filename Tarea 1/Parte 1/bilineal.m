function Y = bilineal(A, tol=51)
  % Filtro Bilineal para una imagen a color
  % A: imagen en formato uint8 a la cual realizar el algoritmo
  % tol: tolerancia minima en formato double
  % Y: imagen filtrada en formato uint8
  
  % Se realiza una copia de los bordes de la imagen A, aumentando
  % su tamaño en dos filas y dos columnas
  B = expandir_imagen(A);
  
  B = double(B); % Cambio a formato double
  
  rojo = B(:, :, 1); % Canal rojo
  verd = B(:, :, 2); % canal verde
  azul = B(:, :, 3); % Canal azul
  
  % Se aplica el filtro a cada uno de los canales
  A(:, :, 1) = bilineal1D(rojo, tol); % Canal rojo
  A(:, :, 2) = bilineal1D(verd, tol); % Canal verde
  A(:, :, 3) = bilineal1D(azul, tol); % Canal azul  
  
  Y = uint8(A);
endfunction
