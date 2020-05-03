clc
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
Image_dim = size(image);
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

Stream8Bits = reshape (dataDeMod1,numel(image),8); 
DecImage = uint8(bi2de(Stream8Bits));
rec_image = reshape(DecImage,Image_dim);


%%plots
subplot(1,2,1);
imshow(image);
title('Original Image');

subplot(1,2,2);
imshow(rec_image); 
title('Received Image')