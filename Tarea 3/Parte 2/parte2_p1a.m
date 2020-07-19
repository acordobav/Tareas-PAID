clc; clear; close all;
% Canal rojo de A
Ar = [5 10 15 20;
      4  8 12 16;
      3  6  9 12;
      2  4  6  8];
% Canal verde de A  
Ag = [1 2 3  4;
      1 3 5  7;
      2 4 6  8;
      1 4 7 10];
% Canal azul de A
Ab = [ 0  0  0  0;
       5  5  5  5;
      10 10 10 10;
      15 15 15 15];
% Creacion de la matriz A
A = cat(3, Ar, Ag, Ab);
   
% % Creacion de la matriz B
B(:,:,1) = A(:,:,1)>5;
B(:,:,2) = (A(:,:,3) >= 10) & (A(:,:,2) < 5);