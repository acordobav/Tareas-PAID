function B = mediana(A)
  [m,n] = size(A);
  B = zeros(m,n);

  % Calcular el filtro en los bordes de la imagen

  %Esquina superior izquierda
  x = 1; y = 1;
  vecAux = [A(x, y+1) A(x+1, y) A(x+1, y+1) A(x,y)];
  B(x,y) = median(vecAux);

  %Esquina superior derecha
  x = 1; y = n;
  vecAux = [A(x, y-1) A(x+1, y-1) A(x+1, y) A(x,y)];
  B(x,y) = median(vecAux);

  %Esquina inferior izquierda
  x = m; y = 1;
  vecAux = [A(x-1, y) A(x-1, y+1) A(x, y+1) A(x,y)];
  B(x,y) = median(vecAux);

  %Esquina inferior derecha
  x = m; y = n;
  vecAux = [A(x-1, y-1) A(x-1, y) A(x, y-1) A(x,y)];
  B(x,y) = median(vecAux);

  %Bordes superior e inferior
  for x = 1:m
    for y = 2:n-1
    
      %Borde superior
      if (x == 1)
        Bloque = A(x:x+1, y-1:y+1);
        vecAux = Bloque(:);
        B(x,y) = median(vecAux);
      endif
      
      %Borde inferior
      if (x == m)
        Bloque = A(x-1:x, y-1:y+1);
        vecAux = Bloque(:);
        B(x,y) = median(vecAux);
      endif
      
    endfor
  endfor

  %Bordes izquierda y derecha
  for x = 2:m-1
    for y = 1:n
      
      %Borde izquierdo
      if (y == 1)
        Bloque = A(x-1:x+1, y:y+1);
        vecAux = Bloque(:);
        B(x,y) = median(vecAux);
      endif
      
      %Borde derecho
      if (y == n)
        Bloque = A(x-1:x+1, y-1:y);
        vecAux = Bloque(:);
        B(x,y) = median(vecAux);
      endif
      
    endfor
  endfor

  %Calcular el filtro en la "parte central" de la imagen
  for x = 2:m-1
    for y = 2:n-1
      bloque = A(x-1:x+1,y-1:y+1); %Bloque para calcular la mediana
      vecAux = bloque(:); %Convertir una matriz en un vector, concatenando las columnas
      B(x,y) = median(vecAux);
    endfor
  endfor
  
endfunction
