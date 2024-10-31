function [] = ENSC180Assignment1Part2(input_string)

%Q2.2a Reading the image, displaying the image and the first 8x8 pixel
%values
img = imread(input_string);
figure
imshow(img)
img8x8 = double(img(1:8, 1:8));
disp(img8x8)

%Q2.2b Calling the max pooling function
downsizeimg1 = Max_Pooling(img);

%Q2.2c Showing the downsized image and the first 4x4 pixel values
figure
imshow(downsizeimg1)
img4x4 = double(downsizeimg1(1:4, 1:4));
disp(img4x4)

%Q2.2d saving the new downsized image with a '1' postfix
[path, file, ext] = fileparts(input_string);
postfix1 = '1';
file1 = strcat(file, postfix1);
newimagefilename1 = [path, [file1, ext]];
imwrite(downsizeimg1, newimagefilename1);

%Q2.2e Downsizing the image again, displaying the 2x2 pixel values, and
%saving that image with a postfix of '2'
downsizeimg2 = Max_Pooling(downsizeimg1);
figure
imshow(downsizeimg2)
img2x2 = double(downsizeimg2(1:2, 1:2));
disp(img2x2)

postfix2 = '2';
file2 = strcat(file, postfix2);
newimagefilename2 = [path, [file2, ext]];
imwrite(downsizeimg2, newimagefilename2);
end

