function Y = promedio1D(A, tol=51)
  % Filtro Promedio para una imagen en escala de grises
  % A: imagen en formato double a la cual realizar el algoritmo
  % tol: tolerancia minima en formato double
  % Y: imagen filtrada en formato double
  [m, n] = size(A);
  for i = 1:m
    for j = 1:n
      vecindario = [];
      
      i_ant = i - 1; % Fila anterior
      i_sig = i + 1; % Fila siguiente
      j_ant = j - 1; % Columna anterior
      j_sig = j + 1; % Columna siguiente
      
      % Verificacion columna izquierda
      if(j_ant != 0)
        % Verificacion fila anterior
        if (i_ant != 0)
          vecindario = [vecindario A(i_ant, j_ant, :)];
        end
        % Verificacion fila siguiente
        if(i_sig != m+1)
          vecindario = [vecindario A(i_sig, j_ant, :)];
        end
        % Caso fila actual
        vecindario = [vecindario A(i, j_ant, :)];
      endif
      
      % Verificacion columna derecha
      if(j_sig != n+1)
        % Verificacion fila anterior
        if (i_ant != 0)
          vecindario = [vecindario A(i_ant, j_sig, :)];
        end
        % Verificacion fila siguiente
        if(i_sig != m+1)
          vecindario = [vecindario A(i_sig, j_sig, :)];    
        end
        % Caso fila actual
        vecindario = [vecindario A(i, j_sig, :)];
      endif     
    
      prom = mean(vecindario); % Se calcula el promedio del vecindario
      
      % Diferencia entre el pixel original y el obtenido con el promedio
      dif = abs(A(i, j) - prom(:, :));
      
      % Se verifica si el pixel sobrepasa la tolerancia    
      if (dif >= tol)
        A(i, j) = prom;
      endif  
    end
  end
  Y = A;
endfunction