im          = imread('../Golden_Temple_preview.jpg');
im          = rgb2gray(im);
sigma0      = 1;
k           = sqrt(2);
levels      = [-1 0 1 2 3 4];
th_contrast = 0.03;
th_r        = 12;

[locs,GaussianPyramid] = DoGdetector(im,sigma0,k,levels,th_contrast,th_r);

figure
imshow(im)
hold on
plot(locs(:,2),locs(:,1),'*');