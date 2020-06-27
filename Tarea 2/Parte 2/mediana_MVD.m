function B = mediana_MVD(A)
  A = sort(A);
  if (A(2) == 255)
    B = A(1);
  elseif (A(2) == 0)
    B = A(3);
  elseif (0 < A(2) < 255)
    B = A(2);
  endif
endfunction
