clc; clear;

A = imread('imagen1.jpg');
B = imread('imagen0.jpg');

tic
Y = promedio(A);
t1 = toc
  
subplot(1, 3, 1);
imshow(B);
title('Imagen sin ruido');

subplot(1, 3, 2);
imshow(A);
title('Imagen con ruido');


subplot(1, 3, 3);
imshow(uint8(Y));
title('Imagen filtrada')

imwrite(Y, 'promedio.jpg');