gbvs_install

a = imread('../Golden_Temple_preview.jpg');
map = gbvs(a);

subplot(2,1,1), subimage(map.master_map_resized)
title('graph based visual saliency')
subplot(2,1,2), subimage(a);
title('original image')