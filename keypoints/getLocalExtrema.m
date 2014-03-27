function locs = getLocalExtrema(DoGPyramid,DoGLevels, PrincipalCurvature,th_contrast,th_r)
[rows,cols,layers] =  size(DoGPyramid);
buffer       =  zeros(rows,cols,layers-1);
% This funtion tried to find out if a point is the extrema in its 10 point
% neighbourhood. 8 in plane and 2 above and below

%I tried a couple of funtions like bsxfuntion etc, but this seemed to be
%the fastest. sorry for poor readablily and the number of loops

for i_1 = 1:layers-1
    buffer(:,:,i_1) = DoGPyramid(:,:,i_1+1) - DoGPyramid(:,:,i_1);
end
%This one i performed so that i could just check the sign changes in above
%and below scale and then decide if we need to check neighbours

test=0;
locs = [];
for i_2 = 1:layers-2
%for all the layers
    for i_3 = 1:rows
        for i_4 = 1:cols
            if (PrincipalCurvature(i_3,i_4,i_2+1)<th_r) && ...
                (abs(DoGPyramid(i_3,i_4,i_2+1)) > th_contrast)
                %threshold for curvature checked    
                if (buffer(i_3,i_4,i_2)>0 && buffer(i_3,i_4,i_2+1) <0)
                    %if current point is extrema than scale above and below    
                    if ((i_3 ~=1 && i_3~=2) && (i_3 ~=rows-1 && i_3~=rows)) && ((i_4 ~=1 && i_4 ~=2) && (i_4 ~= cols-1 && i_4~=cols))
                        %check the bounds of image.    
                        if DoGPyramid(i_3,i_4,i_2+1) == max(max(DoGPyramid(i_3-1:i_3+1,i_4-1:i_4+1,i_2+1)));
                            %check if max based on signs of scale above and below    
                            locs = [locs;[i_3 i_4 i_2+1]];
                        end
                    end
                elseif (buffer(i_3,i_4,i_2) <0 && buffer(i_3,i_4,i_2+1) >0)
                    if i_3 ~=1 && i_3 ~=rows && i_4 ~= 1 && i_4 ~= cols
                        if DoGPyramid(i_3,i_4,i_2+1) == min(min(DoGPyramid(i_3-1:i_3+1,i_4-1:i_4+1,i_2+1)));
                            %similarly minima based on extrema values
                            locs = [locs;[i_3 i_4 i_2+1]];
                        end
                    end
                end
            end
            test=test+1;    
        end
    end
end