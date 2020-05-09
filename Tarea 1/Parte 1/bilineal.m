function Y = bilineal(A)
  % Funcion que utiliza el algoritmo de interpolacion bilineal para
  % eliminar los pixeles faltantes de una imagen
  % A es la imagen en formato uint8
  % Y es la imagen resultante en formato uint8
  [m, n, r] = size(A);
  
  % Se realiza una copia de los bordes de la imagen A, aumentando
  % su tamaño en dos filas y dos columnas
  B = expandir_imagen(A);
  B = im2double(B);
  
  % Vector con los canales en aproximadamente cero
  cero = zeros(1, 1, r) + 0.4; 
  
  for x = 2:m+1
    for y = 2:n+1
      if (B(x, y, :) <= cero)
        x1 = x - 1; % Fila anterior
        x2 = x + 1; % Fila siguiente
        y1 = y - 1; % Columna anterior
        y2 = y + 1; % Columna siguiente
        
        % Interpolacion lineal en el eje x
        a = ((x2 - x) / (x2 - x1));
        b = ((x - x1) / (x2 - x1));
        f_R1 = a * B(x1, y1, :) + b * B(x2, y1, :);       
        f_R2 = a * B(x1, y2, :) + b * B(x2, y2, :);
  
        % Interpolacion lineal en el eje y
        c = ((y2 - y) / (y2 - y1));
        d = ((y - y1) / (y2 - y1));
        f_P = c * f_R1 + d * f_R2;

        B(x, y, :) = f_P;
      endif  
    endfor  
  endfor
  Y = B(2:m+1, 2:n+1, :);
endfunction