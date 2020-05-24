function Y = bilineal1D(A, tol=51)
  % Funcion que utiliza el algoritmo de interpolacion bilineal para
  % eliminar los pixeles faltantes de una imagen en escala de grises
  % A: imagen que se desea filtrar en formato double 
  % Y: imagen filtrada en formato double
  [m, n] = size(A);
  
  for x = 2:m-1
    for y = 2:n-1
      x1 = x - 1; % Fila anterior
      x2 = x + 1; % Fila siguiente
      y1 = y - 1; % Columna anterior
      y2 = y + 1; % Columna siguiente
      
      % Interpolacion lineal en el eje x
      a = ((x2 - x) / (x2 - x1));
      b = ((x - x1) / (x2 - x1));
      f_R1 = a * A(x1, y1) + b * A(x2, y1);       
      f_R2 = a * A(x1, y2) + b * A(x2, y2);

      % Interpolacion lineal en el eje y
      c = ((y2 - y) / (y2 - y1));
      d = ((y - y1) / (y2 - y1));
      f_P = c * f_R1 + d * f_R2;

      % Diferencia entre el pixel original y el obtenido con el promedio
      dif = abs(A(x, y) - f_P);
      
      % Se verifica si el pixel sobrepasa la tolerancia    
      if (dif >= tol)
        A(x, y) = f_P;
      endif  
    endfor  
  endfor
  Y = A(2:m-1, 2:n-1);
endfunction