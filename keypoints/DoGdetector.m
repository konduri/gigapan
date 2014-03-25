function [locs,GaussianPyramid] = DoGdetector(im,sigma0,k,levels,th_contrast,th_r)
GaussianPyramid = createGaussianPyramid(im, sigma0 , k, levels);
%We now have Gaussian Pyramid, which is a R*C*len(levels) matrix, where
%each layer represents the gaussian smoothed image. the gaussian is given
%in the create gaussain funtion (sigma0*k^levels(i))

[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid,levels);
%see respective functions for what they do
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locs = getLocalExtrema(DoGPyramid,DoGLevels, PrincipalCurvature,th_contrast,th_r);