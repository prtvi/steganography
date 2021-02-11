% img2img - encrypt
% hides an image inside of another
clc;

disp('Make sure the dimensions for both the images are the same');
message_img = input('Enter the full path to the image to be hidden (message): ', 's');
foreground_img = input('Enter the full path to the foreground (cover) image: ', 's');

[filepath, name, ext] = fileparts(message_img);

% filepath for the output image
output_img = strcat(filepath, '\', 'output(encrypted).png');

% number of bits to replace
bits_to_replace = 4;
divider = power(2, bits_to_replace);

% reading the images
message = imread(message_img);
foreground = imread(foreground_img);

% extracting the dimensions of the image
dimensions = size(foreground);
w = dimensions(1);
h = dimensions(2);

% initializing the 2D matrices which will store the pixel values of the images
% rf - red-foreground, rm - red-message, similarly for green and blue
rf = zeros(w, h); rm = zeros(w, h);
gf = zeros(w, h); gm = zeros(w, h);
bf = zeros(w, h); bm = zeros(w, h);

% initilizing the matrix for the output image
output = zeros(w, h, 3, 'uint8');

for i = 1:1:w
    for j = 1:1:h
        % accessing each pixel from the original images, modifying them and substituting in output
        
        % for red
        rf(i, j) = foreground(i, j, 1); rm(i, j) = message(i, j, 1);
        output(i, j, 1) = (floor(rf(i, j)/divider)*divider) + floor(rm(i, j)/divider);

        % for green
        gf(i, j) = foreground(i, j, 2); gm(i, j) = message(i, j, 2);
        output(i, j, 2) = (floor(gf(i, j)/divider)*divider) + floor(gm(i, j)/divider);
        
        % for blue
        bf(i, j) = foreground(i, j, 3); bm(i, j) = message(i, j, 3);
        output(i, j, 3) = (floor(bf(i, j)/divider)*divider) + floor(bm(i, j)/divider);
        
    end
end

% writing to the output image (encrypted)
imwrite(output, output_img);
clc;

disp(strcat('File - output(encrypted).png', ' saved at ', filepath));
imshow(output_img);
title('Encrypted image');
