% gbvs_install

% a = imread('../Golden_Temple_preview.jpg');
a = subsampled_img;
map_gbvs = gbvs(a);
map_itti = ittikochmap(a);



saliency_final = (map_gbvs.master_map_resized).*(map_itti.master_map_resized);

    IM1 = map_gbvs.master_map_resized;
    IM2 = map_itti.master_map_resized;
    IM1 = IM1 - min(IM1(:)) ;
    IM1 = IM1 / max(IM1(:)) ;
imshow(IM1)
    
    IM2 = IM2 - min(IM2(:)) ;
    IM2 = IM2 / max(IM2(:)) ;
    imshow(IM2)




imagesc(saliency_final)


%%

imagesc(IM1+IM2)


    



% imshow(saliency_final)
 
% subplot(2,1,1), subimage(map_gbvs.master_map_resized)
% title('graph based visual saliency')
% subplot(2,1,2), subimage(a);
% title('original image')