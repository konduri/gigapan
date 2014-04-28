function [points] = log(img,o_nb_blobs)
    % input image
    img = double(img(:,:,1));
        
    % number of blobs detected
    if nargin==1
        nb_blobs = 350;
    else
        nb_blobs = o_nb_blobs;
    end
    
    % Laplacian of Gaussian parameters
    sigma_begin = 2;
    sigma_end   = 15;
    sigma_step  = 1;
    sigma_array = sigma_begin:sigma_step:sigma_end;
    sigma_nb    = numel(sigma_array);
        
    % variable
    img_height  = size(img,1);
    img_width   = size(img,2);
        
    % calcul scale-normalized laplacian operator
    snlo = zeros(img_height,img_width,sigma_nb);
    for i=1:sigma_nb
        sigma       = sigma_array(i);
        snlo(:,:,i) = sigma*sigma*imfilter(img,fspecial('log', floor(6*sigma+1), sigma),'replicate');
    end
        
    % search of local maxima
    snlo_dil             = imdilate(snlo,ones(3,3,3));
    blob_candidate_index = find(snlo==snlo_dil);
    blob_candidate_value = snlo(blob_candidate_index);
    [tmp,index]          = sort(blob_candidate_value,'descend');
    blob_index           = blob_candidate_index( index(1:min(nb_blobs,numel(index))) );
    [lig,col,sca]        = ind2sub([img_height,img_width,sigma_nb],blob_index);
    points               = [lig,col,3*reshape(sigma_array(sca),[size(lig,1),1])];
    
end