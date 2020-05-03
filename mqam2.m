clc
close all
%%initialize vars
SNR = 20;
M1 = 4;
M2 = 16;
M3 = 64;
% for M1
[modstream1,image_dim,image]=Transmitter(M1,'student.jpg');
y1=channel(modstream1,SNR);
[rec_im1,dataDeMod1]=Receiver(y1,M1,image_dim);
% for M2
[modstream2,image_dim,image]=Transmitter(M2,'student.jpg');
y2=channel(modstream2,SNR);
[rec_im2,dataDeMod2]=Receiver(y2,M2,image_dim);
% for M3
[modstream3,image_dim,image]=Transmitter(M3,'student.jpg');
y3=channel(modstream3,SNR);
[rec_im3,dataDeMod3]=Receiver(y3,M3,image_dim);
%%plots
subplot(2,2,1);
imshow(image);
title('Original Image');

subplot(2,2,2);
imshow(rec_im1); 
title('Received Image M = 4')

subplot(2,2,3);
imshow(rec_im2); 
title('Received Image M = 16')

subplot(2,2,4);
imshow(rec_im3); 
title('Received Image M = 64')
