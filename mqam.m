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
image = reshape(image,numel(image),1);
binImage = de2bi(image);
bitStream = reshape(binImage',numel(binImage),1);

%%modulate
modStream1 = qammod(image,M1); %gray code modulated data with M = 4
modStream2 = qammod(image,M2);
modStream3 = qammod(image,M3);

%%received signal
y1 = awgn(modStream1,snr,'measured');
y2 = awgn(modStream2,snr,'measured');
y3 = awgn(modStream3,snr,'measured');
