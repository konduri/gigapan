function points = gilles(im,o_radius)
    % only luminance value
    im = im(:,:,1);

    % variables
    if nargin==1
        radius = 2.5;
    else
        radius = o_radius;
    end
    mask = fspecial('disk',radius)>0;

    % compute local entropy
    loc_ent = entropyfilt(im,mask);

    % find the local maxima
    [l,c,tmp] = findLocalMaximum(loc_ent,radius);

    % keep only points above a threshold
    [l,c]     = find(tmp>0.95*max(tmp(:)));
    points    = [l,c,repmat(radius,[size(l,1),1])];

end