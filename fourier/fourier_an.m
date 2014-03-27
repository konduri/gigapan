%Import images
function b = fourier_an(block_struct)

imageA = block_struct.data;
% imageA = imread('../Golden_Temple_preview.jpg','jpg');
% imageB = imread('../panorama.jpg','jpg');
%Display images
imageA = rgb2gray(imageA);
% imageB = rgb2gray(imageB);
figure, imshow(imageA)
title('Image A - Golden Temple')
% figure, imshow(imageB)
% title('Image B - panorama')
%Perform 2D FFTs
fftA = fft2(imageA);
% fftB = fft2(imageB);
%Display magnitude and phase of 2D FFTs
figure, imshow(abs(fftshift(fftA)),[24 10000]), colormap gray
title('Image A FFT2 Magnitude')
b = abs(fftshift(fftA));
figure, imshow(log(1+abs(fftA)),[])%,[-1 5]); colormap(jet); colorbar
title('Image A FFT2 Magnitude visualization')
figure, imshow(angle(fftshift(fftA)),[-pi pi]), colormap gray
title('Image A FFT2 Phase')
% figure, imshow(abs(fftshift(fftB)),[24 100000]), colormap gray
% title('Image B FFT2 Magnitude')
% figure, imshow(angle(fftshift(fftB)),[-pi pi]), colormap gray
% title('Image B FFT2 Phase')
