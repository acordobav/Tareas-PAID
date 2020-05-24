clc; clear;

A = imread('imagen1.jpg');
O = imread('imagen0.jpg');

tic
Y1 = promedio(A);
t1 = toc

tic
Y2 = bilineal(A);
t1 = toc

Y1 = double(Y1);
Y2 = double(Y2);

nr_p = norm(Y1(:, :, 1),'fro'); % Norma canal rojo promedio
ng_p = norm(Y1(:, :, 2),'fro'); % Norma canal verde promedio
nb_p = norm(Y1(:, :, 3),'fro'); % Norma canal azul promedio

nr_b = norm(Y2(:, :, 1),'fro'); % Norma canal rojo bilineal
ng_b = norm(Y2(:, :, 2),'fro'); % Norma canal verde bilineal
nb_b = norm(Y2(:, :, 3),'fro'); % Norma canal azul bilineal

nr_o = norm(O(:, :, 1),'fro'); % Norma canal rojo original
ng_o = norm(O(:, :, 2),'fro'); % Norma canal verde original
nb_o = norm(O(:, :, 3),'fro'); % Norma canal azul original

[nr_o nr_p nr_b]
[ng_o ng_p ng_b]
[nb_o nb_p nb_b]

