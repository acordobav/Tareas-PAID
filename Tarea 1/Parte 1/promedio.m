function Y = promedio(A, tol)
  % A: imagen en formato double a la cual realizar el algoritmo
  % tol: tolerancia minima en formato double
  
  A = im2double(A);
  [m, n, r] = size(A);
  
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
    
    dif_rojo = A(i, j, 1) - prom(:, :, 1);
    dif_verde = A(i, j, 2) - prom(:, :, 2);
    dif_azul = A(i, j, 3) - prom(:, :, 3);
    
    norm_rojo = norm(dif_rojo, 'fro');
    norm_verde = norm(dif_verde, 'fro');
    norm_azul = norm(dif_azul, 'fro');
    
    % Se verifica si el pixel sobrepasa la tolerancia    
    if (norm_rojo >= tol) || (norm_verde >= tol) || (norm_azul >= tol) 
      A(i, j, :) = prom;
    endif  
      
    end
  end
  Y = A;
endfunction