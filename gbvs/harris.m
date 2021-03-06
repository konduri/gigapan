function points = harris(im)
    im = double(im(:,:,1));
    sigma = 1.5;

    % derivative masks
    s_D = 0.7*sigma;
    x  = -round(3*s_D):round(3*s_D);
    dx = x .* exp(-x.*x/(2*s_D*s_D)) ./ (s_D*s_D*s_D*sqrt(2*pi));
    dy = dx';

    % image derivatives
    Ix = conv2(im, dx, 'same');
    Iy = conv2(im, dy, 'same');

    % sum of the Auto-correlation matrix
    s_I = sigma;
    g = fspecial('gaussian',max(1,fix(6*s_I+1)), s_I);
    Ix2 = conv2(Ix.^2, g, 'same'); % Smoothed squared image derivatives
    Iy2 = conv2(Iy.^2, g, 'same');
    Ixy = conv2(Ix.*Iy, g, 'same');

    % interest point response
    cim = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps);				% Alison Noble measure.
    % k = 0.06; cim = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;	% Original Harris measure.

    % find local maxima on 3x3 neighborgood
    [r,c,max_local] = findLocalMaximum(cim,3*s_I);

    % set threshold 1% of the maximum value
    t = 0.02*max(max_local(:));

    % find local maxima greater than threshold
    [r,c] = find(max_local>=t);

    % build interest points
    points = [r,c];
end