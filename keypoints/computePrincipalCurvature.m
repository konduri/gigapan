function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%this function has been defined to add all the elements of a matrix. to add
%the elements in our window that we slide across to find the PC
[~,~,layers]  = size(DoGPyramid);
PrincipalCurvature  = zeros(size(DoGPyramid));
for i_1 = 1:layers
    img            = DoGPyramid(:,:,i_1);
    [gx, gy]       = gradient(img);
    [gxx, gxy]     = gradient(gx);
    [~  , gyy]     = gradient(gy);
    PrincipalCurvature(:,:,i_1)=((gxx+gyy).*(gxx+gyy))./((gxx.*gyy)-(gxy.*gxy));
end 

%PC is calclated by  (trace(H))^2/det(H)
% check out section 4.1 in http://www.cs.ubc.ca/~lowe/papers/ijcv04.pdf

