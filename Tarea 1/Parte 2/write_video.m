pkg load video;
pkg load image;

video = VideoWriter('animacion.mp4');
% video.FrameRate = 1;
open(video);

for i = 1:70
  imagen = imread(['test/test' num2str(i) '.jpg']);
  for j = 1:9
    writeVideo(video, imagen);
  endfor
endfor

close(video);


%{
% Animacion de las imagenes filtradas
for i = 1:size(r_vec)(2)
  f=figure(2);
  set(f,'Visible', 'off')
  
  % Plot de la imagen con ruido
  subplot(1, 2, 1);
  imshow(A);
  title('Imagen con ruido');
  
  % Plot de la imagen filtrada
  subplot(1, 2, 2);
  imshow(im_filtradas(:, :, :, i));
  title(['Imagen Filtrada r = ' num2str(r_vec(i))]);

  saveas(f,['test/test' num2str(i)],'jpg')
    
  % Pausa de 0.5 segundos
  pause(0.5)
endfor
%}