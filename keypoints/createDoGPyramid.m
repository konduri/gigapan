function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid,levels)
%Function should return DOG pyramid r*c*(L-1)
DoGPyramid = zeros([size(GaussianPyramid(:,:,1)),length(levels)-1]);
DoGLevels  = zeros(length(levels)-1,1);
%preallocate memory

for i_1 = 1:length(levels)-1
    DoGPyramid(:,:,i_1) = GaussianPyramid(:,:,i_1)-GaussianPyramid(:,:,i_1+1);
    %fairly straight forward, find the difference of gaussians and creates
    %a DOG pyramid
    DoGLevels(i_1)      = levels(i_1+1);
end