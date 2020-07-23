function C = inpainting(A, B, kernel, num_iteration)
  % A: imagen que tiene que ser restaurada
  % B: mascara con la region a restaurar
  % kernel: kernel de difusion
  % num_iteration: num cantidad de iteraciones
  
  B = logical(B);
  for iter = 1:num_iteration
    C = conv2(A, kernel,'same');
    A(B) = C(B);
  endfor
endfunction
