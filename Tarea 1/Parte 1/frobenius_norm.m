function Y = frobenius_norm(A)
  % A es la imagen en formato double
  % Y es una lista con la norma de cada canal, primero
  % el canal rojo, luego el verde y por ultimo el azul
  norm_red = norm(A(:, :, 1),'fro');
  norm_green = norm(A(:, :, 2),'fro');
  norm_blue = norm(A(:, :, 3),'fro');
  results = [norm_red norm_green norm_blue];
  Y = results;
endfunction
