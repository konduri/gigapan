%% Parameters for the program
highres_img = imread('84.tiff');

final_dim = size(highres_img);
tile_dim =  [3456, 5184, 3];    % Alter as needed

min_overlap = 0.3;              % Alter as needed
subsampling_factor = 5;         % Alter as needed

max_new  = 1 - min_overlap;

%% Calculate the number and locations of tiles
num_rows = 1 + ceil((final_dim(1) - tile_dim(1))/(max_new * tile_dim(1)));
num_cols = 1 + ceil((final_dim(2) - tile_dim(2))/(max_new * tile_dim(2)));

row_overlap = round((num_rows * tile_dim(1) - final_dim(1))/(num_rows-1));
row_offset = tile_dim(1) - row_overlap;
row_starts = ones(1, num_rows);
for i = 2:num_rows-1
    row_starts(i) = row_starts(i-1) + row_offset;
end
row_starts(num_rows) = final_dim(1) - tile_dim(1);

col_overlap = round((num_cols * tile_dim(2) - final_dim(2))/(num_cols-1));
col_offset = tile_dim(2) - col_overlap;
col_starts = ones(1, num_cols);
for i = 2:num_cols-1
    col_starts(i) = col_starts(i-1) + col_offset;
end
col_starts(num_cols) = final_dim(2) - tile_dim(2);

tile_locations = zeros(num_rows, num_cols, 4);
for i = 1:num_rows
    for j = 1:num_cols
        tile_locations(i,j,1) = row_starts(i);
        tile_locations(i,j,2) = row_starts(i) + tile_dim(1);
        tile_locations(i,j,3) = col_starts(j);
        tile_locations(i,j,4) = col_starts(j) + tile_dim(2);
    end
end

%% Browse through tiles and determine whether to click or not
subsampled_img =  imresize(highres_img, 1/subsampling_factor);
oversampled_img = imresize(subsampled_img, subsampling_factor);

subsampled_locs = round((1/subsampling_factor) * tile_locations);

%%

imp_tiles = find_tiles_of_interest(subsampled_img, subsampled_locs);
%%
for i = 1:num_rows
    for j = 1:num_cols
        path = strcat('tiles\row', int2str(i), 'col', int2str(j),'.tiff');
        a = tile_locations(i,j,1);
        b = tile_locations(i,j,2);
        c = tile_locations(i,j,3);
        d = tile_locations(i,j,4);
        
        if imp_tiles(i,j) == 1
            imwrite(highres_img(a:b, c:d, :), path, 'Compression', 'lzw');
        else
            imwrite(oversampled_img(a:b, c:d, :),path,'Compression','lzw');
        end
    end
end