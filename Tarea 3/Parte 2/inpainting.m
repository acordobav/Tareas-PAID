function C = inpainting(A, B, kernel, num_iteration)
  % A imagen que tiene que ser restaurada
  % B mascara
  % kernel de difusion
  % num cantidad de iteraciones
  [m,n] = size(B);
  C = A;
  [xp,yp] = find(B==255);
  for iter = 1:num_iteration
    for k = 1:length(xp)
        i = xp(k); j = yp(k);
        bloque = C(i-1:i+1,j-1:j+1);
        C(i,j) = sum((bloque.*kernel)(:));
    endfor
  endfor
endfunction

