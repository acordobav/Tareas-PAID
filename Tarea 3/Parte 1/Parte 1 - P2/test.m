clc; clear; close all;

A = [35 40 41 45 50;
     40 40 42 46 52;
     42 46 50 55 55;
     48 52 56 58 60;
     56 60 65 70 75];
     
B = [-2 -1  0;
     -1  1  1;
      0  1  2];
 
[m,n] =  size(A);
C = A;

for i = 2:m-1
  for j = 2:n-1
    bloque = A(i-1:i+1,j-1:j+1);
    C(i,j) = sum((sum(bloque.*B)));
  endfor
endfor
