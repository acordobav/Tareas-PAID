clc; clear;

A = imread('imagen1.jpg');
A = im2double(A);

B = imread('imagen0.jpg');
B = im2double(B);

% norma_a = frobenius_norm(A);
% norma_b = frobenius_norm(B);

C = promedio(A, 0.001);
