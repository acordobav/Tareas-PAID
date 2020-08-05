clear;clc; close all

pkg load image

%Imagen Original: I1
I1=imread('paisaje.jpg');
I1 = im2double(I1);
subplot(2,2,1)
imshow(I1)
title('(a) paisaje.jpg','FontSize',16)

%Texto: I2
I2=imread('marca.jpg');
I2 = im2double(I2);
I2(I2<0.5)=0; I2(I2>=0.5)=1;
subplot(2,2,2)
imshow(I2)
title('(b) marca.jpg','FontSize',16)

%Imagen a Restaurar: I3
I3=I1+I2;
subplot(2,2,3)
imshow(I3)
title('(c) Imagen a Restaurar','FontSize',16)

%Kernels de difusion
a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];
kernel2 = [c c c; c 0 c; c c c];

%Proceso de Inpainting
num_iteration = 50;
I4 = inpainting(I3, I2, kernel2, num_iteration);
subplot(2,2,4)
imshow(I4)
title('(d) Imagen Restaurada', 'FontSize',16)
