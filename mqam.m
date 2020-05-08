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
modStream1 = qammod(bitStream,M1,'gray','InputType','bit'); %gray code modulated data with M = 4
modStream2 = qammod(bitStream,M2,'gray','InputType','bit');
modStream3 = qammod(bitStream,M3,'gray','InputType','bit');

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
figure('Name','Received Images');
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


%%SNR vs Pe

[numErrorsG1,berG1] = biterr(bitStream, dataDeMod1); %error
[numErrorsG2,berG2] = biterr(bitStream, dataDeMod2);
[numErrorsG3,berG3] = biterr(bitStream, dataDeMod3);
graphSNR = 0:0.25:30;

%%BER vs SNR  
for k = 1:length(graphSNR)
    y = awgn(modStream1,graphSNR(k),'measured');
    y = qamdemod(y,M1,'gray','OutputType','bit');
    [numErrors,ber(k)] = biterr(bitStream, y); %error
end
for k = 1:length(graphSNR)
    y = awgn(modStream2,graphSNR(k),'measured');
    y = qamdemod(y,M2,'gray','OutputType','bit');
    [numErrors,ber2(k)] = biterr(bitStream, y); %error
end
for k = 1:length(graphSNR)
    y = awgn(modStream3,graphSNR(k),'measured');
    y = qamdemod(y,M3,'gray','OutputType','bit');
    [numErrors,ber3(k)] = biterr(bitStream, y); %error
end

thBER = berawgn(graphSNR,'qam',M1);
thBER2 = berawgn(graphSNR,'qam',M2);
thBER3 = berawgn(graphSNR,'qam',M3);

figure;
semilogy(graphSNR,ber,'color','r')
hold on
semilogy(graphSNR,thBER,'color','r','LineStyle','--')
hold on
semilogy(graphSNR,ber2,'color','g')
hold on
semilogy(graphSNR,thBER2,'color','g','LineStyle','--')
hold on
semilogy(graphSNR,ber3,'color','b')
hold on
semilogy(graphSNR,thBER3,'color','b','LineStyle','--')
hold off
title('Gray Encoded')
xlabel("SNR/dB");
ylabel("BER");
legend('M = 4','Theoretical M = 4','M = 16','Theoretical M = 16','M = 64','Theoretical M = 64');
xlim([0 33]);
ylim([10e-8 1]);

for k = 1:length(graphSNR)
    modStreamBin1 = qammod(bitStream,M1,'bin','InputType','bit');
    y1 = awgn(modStreamBin1,graphSNR(k),'measured');
    dataDeModBin1 = qamdemod(y1,M1,'bin','OutputType','bit');
    [numErrors,ber(k)] = biterr(bitStream, dataDeModBin1); %error
end
for k = 1:length(graphSNR)
    modStreamBin2 = qammod(bitStream,M2,'bin','InputType','bit');
    y2 = awgn(modStreamBin2,graphSNR(k),'measured');
    dataDeModBin2 = qamdemod(y2,M2,'bin','OutputType','bit');
    [numErrors,ber2(k)] = biterr(bitStream, dataDeModBin2); %error
end
for k = 1:length(graphSNR)
    modStreamBin3 = qammod(bitStream,M3,'bin','InputType','bit');
    y3 = awgn(modStreamBin3,graphSNR(k),'measured');
    dataDeModBin3 = qamdemod(y3,M3,'bin','OutputType','bit');
    [numErrors,ber3(k)] = biterr(bitStream, dataDeModBin3); %error
end

figure;
semilogy(graphSNR,ber,'color','r')
hold on
semilogy(graphSNR,thBER,'color','r','LineStyle','--')
hold on
semilogy(graphSNR,ber2,'color','g')
hold on
semilogy(graphSNR,thBER2,'color','g','LineStyle','--')
hold on
semilogy(graphSNR,ber3,'color','b')
hold on
semilogy(graphSNR,thBER3,'color','b','LineStyle','--')
hold off
title('Binary Encoded');
xlabel("SNR/dB");
ylabel("BER");
legend('M = 4','Theoretical M = 4','M = 16','Theoretical M = 16','M = 64','Theoretical M = 64');
xlim([0 33]);
ylim([10e-8 1]);