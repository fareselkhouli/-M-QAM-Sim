tic;
clc
close all
%%initialize vars
SNR = 20;
M1 = 4;
M2 = 16;
M3 = 64;
% Reconstructed Image of M1
[modstream1,image_dim,image,bitStream]=Transmitter(M1,'student.jpg');
y1=channel(modstream1,SNR);
[rec_im1,dataDeMod1]=Receiver(y1,M1,image_dim);
% Reconstructed Image of M2
[modstream2,image_dim,image,bitStream]=Transmitter(M2,'student.jpg');
y2=channel(modstream2,SNR);
[rec_im2,dataDeMod2]=Receiver(y2,M2,image_dim);
% Reconstructed Image for M3
[modstream3,image_dim,image,bitStream]=Transmitter(M3,'student.jpg');
y3=channel(modstream3,SNR);
[rec_im3,dataDeMod3]=Receiver(y3,M3,image_dim);

%Question 1.a Constellation scatter plots
scatterplot(y1,1,0)
title('Scatter Plot for M=4, SNR=20dB')
scatterplot(y2,1,0)
title('Scatter Plot for M=16, SNR=20dB')
scatterplot(y3,1,0)
title('Scatter Plot for M=64, SNR=20dB')

% Question 1.b Calculating propability error Pe
[numErrorsG1,berG1] = biterr(bitStream, dataDeMod1); 
[numErrorsG2,berG2] = biterr(bitStream, dataDeMod2);
[numErrorsG3,berG3] = biterr(bitStream, dataDeMod3);

% Question 1.c Plotting transmitted and reconstructed image
figure;
hold on
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

% Question 2 SNR vs Pe

graphSNR = 0:0.25:30;

% plotting gray mapping BER vs SNR  
for k = 1:length(graphSNR)
    y1 = channel(modStream1,graphSNR(k));
    %dataDeMod1 = qamdemod(y1,M1,'gray','OutputType','bit');
    [rec_im1,dataDeMod1]=Receiver(y1,M1,image_dim);
    [numErrors,berG1(k)] = biterr(bitStream, dataDeMod1); %error
end
for k = 1:length(graphSNR)
y2 = channel(modStream2,graphSNR(k));    
%dataDeMod2 = qamdemod(y2,M2,'gray','OutputType','bit');
[rec_im2,dataDeMod2]=Receiver(y2,M2,image_dim);
    [numErrors,berG2(k)] = biterr(bitStream, dataDeMod2); %error
end
for k = 1:length(graphSNR)
    y3 = channel(modStream3,graphSNR(k));
    %dataDeMod3 = qamdemod(y3,M3,'gray','OutputType','bit');
    [rec_im3,dataDeMod3]=Receiver(y3,M3,image_dim);
    [numErrors,berG3(k)] = biterr(bitStream, dataDeMod3); %error
end
% theoritical expected propability 
thBER = berawgn(graphSNR,'qam',M1);
thBER2 = berawgn(graphSNR,'qam',M2);
thBER3 = berawgn(graphSNR,'qam',M3);

% Pe vs SNR with both theoritcal and gray mapping values
figure;
semilogy(graphSNR,berG1,'color','r')
hold on
semilogy(graphSNR,thBER,'color','r','LineStyle','--')
hold on
semilogy(graphSNR,berG2,'color','g')
hold on
semilogy(graphSNR,thBER2,'color','g','LineStyle','--')
hold on
semilogy(graphSNR,berG3,'color','b')
hold on
semilogy(graphSNR,thBER3,'color','b','LineStyle','--')
hold off
title('Gray Encoded')
xlabel("SNR/dB");
ylabel("BER");
legend('M = 4','Theoretical M = 4','M = 16','Theoretical M = 16','M = 64','Theoretical M = 64');
xlim([0 33]);
ylim([10e-8 1]);
% Question 4 SNR vs Pe without Gray mapping
% plotting binary mapping BER vs SNR  
for k = 1:length(graphSNR)
    modStreamBin1 = qammod(bitStream,M1,'bin','InputType','bit'); %binary modulation
    y1 = channel(modStreamBin1,graphSNR(k));
    dataDeModBin1 = qamdemod(y1,M1,'bin','OutputType','bit'); % demodulation
    [numErrors,berB1(k)] = biterr(bitStream, dataDeModBin1); %error
end
for k = 1:length(graphSNR)
    modStreamBin2 = qammod(bitStream,M2,'bin','InputType','bit');
    y2 = channel(modStreamBin2,graphSNR(k));
    dataDeModBin2 = qamdemod(y2,M2,'bin','OutputType','bit');
    [numErrors,berB2(k)] = biterr(bitStream, dataDeModBin2); %error
end
for k = 1:length(graphSNR)
    modStreamBin3 = qammod(bitStream,M3,'bin','InputType','bit');
    y3 = channel(modStreamBin3,graphSNR(k));
    dataDeModBin3 = qamdemod(y3,M3,'bin','OutputType','bit');
    [numErrors,berB3(k)] = biterr(bitStream, dataDeModBin3); %error
end
% Pe vs SNR with both theoprtical and binary mapping values
figure;
semilogy(graphSNR,berB1,'color','r')
hold on
semilogy(graphSNR,thBER,'color','r','LineStyle','--')
hold on
semilogy(graphSNR,berB2,'color','g')
hold on
semilogy(graphSNR,thBER2,'color','g','LineStyle','--')
hold on
semilogy(graphSNR,berB3,'color','b')
hold on
semilogy(graphSNR,thBER3,'color','b','LineStyle','--')
hold off
title('Binary Encoded');
xlabel("SNR/dB");
ylabel("BER");
legend('M = 4','Theoretical M = 4','M = 16','Theoretical M = 16','M = 64','Theoretical M = 64');
xlim([0 33]);
ylim([10e-8 1]);

%%binary vs gray econding plots
figure;
semilogy(graphSNR,berB1,'color','r')
hold on
semilogy(graphSNR,berG1,'color','r','LineStyle','--')
hold on
semilogy(graphSNR,berB2,'color','g')
hold on
semilogy(graphSNR,berG2,'color','g','LineStyle','--')
hold on
semilogy(graphSNR,berB3,'color','b')
hold on
semilogy(graphSNR,berG3,'color','b','LineStyle','--')
hold off
title('Binary vs Gray');
xlabel("SNR/dB");
ylabel("BER");
legend('Binary M = 4','Gray M = 4',' Binary M = 16','Gray M = 16','Binary M = 64','Gray M = 64');
xlim([0 33]);
ylim([10e-8 1]);
toc;

