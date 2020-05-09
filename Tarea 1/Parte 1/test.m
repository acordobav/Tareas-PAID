clc; clear;

Aorig = imread('imagen0.jpg');
Aorig = im2double(Aorig);

A = imread('imagen1.jpg');
A = im2double(A);

% B = promedio(A, 60);

%{
n1 = frobenius_norm(Aorig);
n2 = frobenius_norm(A);
n3 = frobenius_norm(B);
%}

z = 0:25:200;

normas = [];


for i = z
  B = promedio(A, i);  
  n = frobenius_norm(B);
  normas = [normas; n];
endfor

% B = promedio(A, z(0));



