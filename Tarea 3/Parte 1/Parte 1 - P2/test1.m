clear;clc; close all
%%%%
pkg load image

%Imagen Original: I1
I1=imread('paisaje.jpg');
subplot(2,2,1)
imshow(I1)
title('(a) paisaje.jpg','FontSize',16)

%Texto: I2
I2=imread('marca.jpg');
I2(I2<50)=0; I2(I2>=50)=255; %Convertir imagen a Binaria. Parte Blanca = Texto. Parte Negra = Valor de 0
subplot(2,2,2)
imshow(I2)
title('(b) marca.jpg','FontSize',16)

%Imagen a Restaurar: I3
I3=I1+I2;
subplot(2,2,3)
imshow(I3)
title('(c) Imagen a Restaurar','FontSize',16)

a = 0.073235;
b = 0.176765;
c = 0.125;
kernel1 = [a b a; b 0 b; a b a];
kernel2 = [c c c; c 0 c; c c c];

[m,n] = size(I2);
I4 = I3;

num_iteration = 7;
for iter = 1:num_iteration 
  for i = 2:m-1
    for j = 2:n-1
      pixel = I2(i,j);
      if pixel == 255
        bloque = I4(i-1:i+1,j-1:j+1);
        I4(i,j) = sum(sum(bloque.*kernel1));
      endif
    endfor
  endfor
endfor

subplot(2,2,4)
imshow(I4)
title('(d) Imagen Restaurada', 'FontSize',16)
