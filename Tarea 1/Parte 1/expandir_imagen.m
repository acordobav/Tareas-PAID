function B = expandir_imagen(A)
  % Funcion que crea una copia de la imagen A repitiendo cada uno
  % de sus cuatro bordes, con una longitud de un pixel.
  % A es la imagen en formato uint8
  % B es la imagen expandida en formato uint8
  
  [m, n, r] = size(A);
  
  % Se construye una matriz que tiene dos filas y dos columnas extras
  B = zeros(m + 2, n + 2, r);

  % Se inserta la matriz A en el centro de la matriz B 
  B(2:m+1, 2:n+1, :) = A(:, :, :);
  
  % Se copian los extremos de A en los extremos de B
  B(1, 2:n+1, :) = A(1, :, :); % Copia la primera fila
  B(m+2, 2:n+1, :) = A(m, :, :); % Copia la ultima fila
  B(2:m+1, 1, :) = A(:, 1, :); % Copia la primera columna
  B(2:m+1, n+2, :) = A(:, n, :); % Copia la ultima columna

  % Se copian los valores para las esquinas
  B(1, 1, :) = A(2, 1, :); % Superior izquierda
  B(1, n+2, :) = A(2, n, :); % Superior derecha
  B(m+2, 1, :) = A(m-1, 1, :); % Inferior izquierda
  B(m+2, n+2, :) = A(m, n-1, :); % Inferior derecha
  
  B = uint8(B);
endfunction