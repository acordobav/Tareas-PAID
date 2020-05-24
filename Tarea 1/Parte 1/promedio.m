function Y = promedio(A, tol=51)
  % Filtro promedio para una imagen a color
  % A: imagen en formato uint8 a la cual realizar el algoritmo
  % tol: tolerancia minima en formato double
  % Y: imagen filtrada en formato uint8
  A = double(A); % Cambio a formato double
  rojo = A(:, :, 1); % Canal rojo
  verd = A(:, :, 2); % canal verde
  azul = A(:, :, 3); % Canal azul
  
  % Se aplica el filtro a cada uno de los canales
  A(:, :, 1) = promedio1D(rojo, tol); % Canal rojo
  A(:, :, 2) = promedio1D(verd, tol); % Canal verde
  A(:, :, 3) = promedio1D(azul, tol); % Canal azul
  
  Y = uint8(A);
endfunction
