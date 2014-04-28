function [imp_tiles_key,imp_tiles_one,imp_tiles_sal,imp_tiles_two] = find_tiles_of_interest(im, ss_loc)

im = rgb2gray(im);

pts_harris =  harris(im);
%%
% pts_log    =  log(im);
%%
pts_gilles =  gilles(im);


poi        =  [pts_harris ; pts_gilles(:,1:2)];%pts_log(:,1:2) ; pts_gilles(:,1:2)];
sz         = size(ss_loc);



% a = subsampled_img;
map_gbvs = gbvs(im);
map_itti = ittikochmap(im);
saliency_final = (map_gbvs.master_map_resized).*(map_itti.master_map_resized);
IM1 = map_gbvs.master_map_resized;
IM2 = map_itti.master_map_resized;
IM1 = IM1 - min(IM1(:));
IM1 = IM1 / max(IM1(:));
imshow(IM1)
    
IM2 = IM2 - min(IM2(:));
IM2 = IM2 / max(IM2(:));
imshow(IM2)

imagesc(saliency_final)
img_salience = IM1+IM2;
imagesc(IM1+IM2)



temp_loc = reshape(ss_loc,[sz(1)*sz(2) sz(3)]);
counter_key  = zeros(sz(1)*sz(2),1);
counter_sal  = zeros(sz(1)*sz(2),1);


for i = 1:sz(1)*sz(2)
    rect = [temp_loc(i,3) temp_loc(i,1) temp_loc(i,4)-temp_loc(i,3) temp_loc(i,2)-temp_loc(i,1)];
    temp = imcrop(img_salience,rect);
    counter_sal(i) = sum(temp(:));
       
   for j = 1:length(poi)
%        rect = [poi(j,2) poi(j,1) poi(j,4)-pos(j,2) pos(j,3)-pos(j,1)];
       if poi(j,1) > temp_loc(i,1) && poi(j,1) < temp_loc(i,2) && poi(j,2) > temp_loc(i,3) && poi(j,2) < temp_loc(i,4)
           counter_key(i) = counter_key(i)+1;
       end
   end
end
       

sum(counter_key(:))
size(poi)

mean_thres_key = mean(counter_key);
mean_thres_sal = mean(counter_sal);

imp_tiles_key  = reshape(counter_key > mean_thres_key, [sz(1) sz(2)]);
imp_tiles_one  = counter_key;

imp_tiles_sal  = reshape(counter_sal > mean_thres_sal, [sz(1) sz(2)]);
imp_tiles_two  = counter_sal;




% 
% figure
% imshow(im)
% hold on
% plot(pts_harris(:,2),pts_harris(:,1),'*');
% title('Image with harris corner detector')
% 
% %%
% % figure
% % imshow(im)
% % hold on
% % plot(pts_log(:,2),pts_log(:,1),'*');
% % title('Image with log detector')
% 
% %%
% figure
% imshow(im)
% hold on
% plot(pts_gilles(:,2),pts_gilles(:,1),'*');
% title('Image with gilles detector')



end
