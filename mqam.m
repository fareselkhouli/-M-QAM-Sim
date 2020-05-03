clc
clear
close all
%%initialize vars
SNR = 20;
M1 = 4;
M2 = 16;
M3 = 64;
k1 = log2(M1); %number of bits per symbol
k2 = log2(M2);
k3 = log2(M3);

%%read image
image = imread('student.jpg');
image_dim = size(image);

imageReshape = reshape(image,numel(image),1);
binImage = de2bi(imageReshape);
bitStream = reshape(binImage',numel(binImage),1);

%%modulate
modStream1 = qammod(bitStream,M1,'InputType','bit'); %gray code modulated data with M = 4
modStream2 = qammod(bitStream,M2,'InputType','bit');
modStream3 = qammod(bitStream,M3,'InputType','bit');

%%received signal
y1 = awgn(modStream1,SNR,'measured');
y2 = awgn(modStream2,SNR,'measured');
y3 = awgn(modStream3,SNR,'measured');

%%demodulator
dataDeMod1 = qamdemod(y1,M1,'gray','OutputType','bit');
dataDeMod2 = qamdemod(y2,M2,'gray','OutputType','bit');
dataDeMod3 = qamdemod(y3,M3,'gray','OutputType','bit');


%%reshape image data
rec_im1 = reshape(dataDeMod1,8,numel(dataDeMod1)/8);
rec_im1 = uint8(bi2de(rec_im1'));
rec_im1 = reshape(rec_im1,image_dim);


rec_im2 = reshape(dataDeMod2,8,numel(dataDeMod2)/8);
rec_im2 = uint8(bi2de(rec_im2'));
rec_im2 = reshape(rec_im2,image_dim);


rec_im3 = reshape(dataDeMod3,8,numel(dataDeMod3)/8);
rec_im3 = uint8(bi2de(rec_im3'));
rec_im3 = reshape(rec_im3,image_dim);

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