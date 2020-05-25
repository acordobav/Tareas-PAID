clc; clear;

A = imread('imagen1.jpg');
O = imread('imagen0.jpg');

tic
Y1 = promedio(A);
t1 = toc

tic
Y2 = bilineal(A);
t1 = toc

Y1 = im2double(Y1);
Y2 = im2double(Y2);
O = im2double(O);

nr_p = norm(Y1(:, :, 1) - O(:, :, 1),'fro'); % Norma canal rojo promedio
ng_p = norm(Y1(:, :, 2) - O(:, :, 2),'fro'); % Norma canal verde promedio
nb_p = norm(Y1(:, :, 3) - O(:, :, 3),'fro'); % Norma canal azul promedio

nr_b = norm(Y2(:, :, 1) - O(:, :, 1),'fro'); % Norma canal rojo bilineal
ng_b = norm(Y2(:, :, 2) - O(:, :, 2),'fro'); % Norma canal verde bilineal
nb_b = norm(Y2(:, :, 3) - O(:, :, 3),'fro'); % Norma canal azul bilineal

[nr_p ng_p nb_p]
[nr_b ng_b nb_b]
