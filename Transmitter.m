function [modstream,image_dim,image,bitStream]=Transmitter(M,imagefilename)
%%read image
image = imread(imagefilename);
image_dim = size(image);
imageReshape = reshape(image,numel(image),1);
binImage = de2bi(imageReshape);
bitStream = reshape(binImage',numel(binImage),1);
%modulate
modstream=qammod(bitStream,M,'InputType','bit'); %gray code modulated data with M
