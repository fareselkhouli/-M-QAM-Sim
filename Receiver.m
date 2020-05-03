function[rec_im,dataDeMod]=Receiver(y,M,image_dim)
%%demodulator
dataDeMod = qamdemod(y,M,'gray','OutputType','bit');
%%reshape image data
rec_im = reshape(dataDeMod,8,numel(dataDeMod)/8);
rec_im = uint8(bi2de(rec_im'));
rec_im = reshape(rec_im,image_dim);
