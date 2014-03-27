a = imread('../Golden_Temple_preview.jpg');
a = mat2gray( rgb2gray(a) );
fun = @(block_struct) ...
     abs(fftshift(fft2(block_struct.data,38,110)));
%     block_struct.data;
b = blockproc(a, [40 100],fun);

imshow(b,[0 100]);
title('fourier analysis on parts of image');


