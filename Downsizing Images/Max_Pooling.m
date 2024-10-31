%Q2.1 Creating the max pooling function, returning a uint8 array
%representing the downsized image
function [PooledArray] = Max_Pooling(ImageArray)
[rows, columns] = size(ImageArray);
pool_rows = rows/2;
pool_columns = columns/2;

PooledArray = zeros(pool_rows, pool_columns);

for i = 1:2:rows
    for j = 1:2:columns
        current_square = ImageArray(i:i+1, j:j+1);
        k = max(max(current_square));
        ii = ceil(i/2);
        jj = ceil(j/2);
        PooledArray(ii,jj) = k;
    end
end

PooledArray = uint8(PooledArray);

end
