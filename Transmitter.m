function modstream=Transmitter(M,imagefilename)
k = log2(M); %number of bits per symbol
%%read image
image = imread(imagefilename);
image = reshape(image,numel(image),1);
binImage = de2bi(image);
bitStream = reshape(binImage',numel(binImage),1);
%%modulate
modstream=qammod(bitStream,M); %gray code modulated data with M
