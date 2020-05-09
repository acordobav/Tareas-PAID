function Y = prom2(A)
A = im2double(A);
[m, n, r] = size(A);
% Vector con los canales en cero
cero = zeros(1, 1, r) + 0.4;
for i = 1:m
for j = 1:n
% Se calcula el promedio en aquellos casos
% donde los tres canales son cero
if (A(i, j, :) <= cero)
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
A(i, j, :) = mean(vecindario);
end
end
end
Y = A;
endfunction