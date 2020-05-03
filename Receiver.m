function rec_image = Receiver(M,imageFileName, dataMod)

image = imread(imageFileName);
Image_dim = size(image);

dataDeMod = qamdemod(dataMod,M,'gray','OutputType','bit');

Stream8Bits = reshape (dataDeMod,numel(image),8); 
DecImage = bi2de(Stream8Bits);
rec_image = reshape(DecImage,Image_dim);

subplot(1,2,1);
imshow(image);
title('Original Image');

subplot(1,2,2);
imshow(rec_image); 
title('Received Image')