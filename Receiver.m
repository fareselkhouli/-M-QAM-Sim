function rec_image = Receiver(M,imageFileName, dataMod)

image = imread(imageFileName);
image_dim = size(image);
elements_image = numel(image);

dataDeMod = qamdemod(dataMod,M,'gray','OutputType','bit');
len = length(dataDeMod);
stream8bit = uint8(dataDeMod);
output_16qam = stream8bit(1:len);
b2 = reshape(output_16qam,8,elements_image)';
dec_16qam =bi2de(b2,'left-msb');
rec_image = reshape(dec_16qam(1:numel(image)),image_dim);

subplot(1,2,1);
imshow(image);
title('Original Image');

subplot(1,2,2);
imshow(rec_image);
title('Received Image')