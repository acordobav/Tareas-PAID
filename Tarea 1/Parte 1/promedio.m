function Y = promedio(A, tol)
  % A: imagen en formato double a la cual realizar el algoritmo
  % tol: tolerancia minima en formato double
  
  A = im2double(A);
  [m, n, r] = size(A);
  
  % Vector con los canales en cero
  tol = zeros(1, 1, r);
  tol(:, :, 1) = tol; % Canal rojo
  tol(:, :, 2) = tol; % Canal verde
  tol(:, :, 3) = tol; % Canal azul
  
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
        
    pix_rojo = A(i, j, 1);
    pix_verde = A(i, j, 2);
    pix_azul = A(i, j, 3);

    dif_rojo = norm(A(i, j, 1) - prom, 'fro');
    dif_verde = norm(A(i, j, 2) - prom, 'fro');
    dif_azul = norm(A(i, j, 3) - prom, 'fro');
    
    % Se verifica si el pixel sobrepasa la tolerancia    
    if pixel >= tol
      A(i, j, :) = prom
    endif  
      
    end
  end
  Y = A;
endfunction