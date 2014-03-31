im = imread('../Golden_Temple_preview.jpg');
im = rgb2gray(im);

pts_harris =  harris(im);
pts_log    =  log(im);
pts_gilles =  gilles(im);

figure
imshow(im)
hold on
plot(pts_harris(:,2),pts_harris(:,1),'*');
title('Image with harris corner detector')


figure
imshow(im)
hold on
plot(pts_log(:,2),pts_log(:,1),'*');
title('Image with log detector')


figure
imshow(im)
hold on
plot(pts_gilles(:,2),pts_gilles(:,1),'*');
title('Image with gilles detector')
