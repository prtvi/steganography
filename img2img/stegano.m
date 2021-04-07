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
% fore_red - red-foreground, msg_red - red-message, similarly for green and blue
fore_red = zeros(w, h); msg_red = zeros(w, h);
fore_green = zeros(w, h); msg_green = zeros(w, h);
fore_blue = zeros(w, h); msg_blue = zeros(w, h);

% initilizing the matrix for the output image
output = zeros(w, h, 3, 'uint8');

for i = 1:1:w
    for j = 1:1:h
        % accessing each pixel from the original images, modifying them and substituting in output
        
        % for red
        fore_red(i, j) = foreground(i, j, 1); msg_red(i, j) = message(i, j, 1);
        output(i, j, 1) = (floor(fore_red(i, j)/divider)*divider) + floor(msg_red(i, j)/divider);

        % for green
        fore_green(i, j) = foreground(i, j, 2); msg_green(i, j) = message(i, j, 2);
        output(i, j, 2) = (floor(fore_green(i, j)/divider)*divider) + floor(msg_green(i, j)/divider);
        
        % for blue
        fore_blue(i, j) = foreground(i, j, 3); msg_blue(i, j) = message(i, j, 3);
        output(i, j, 3) = (floor(fore_blue(i, j)/divider)*divider) + floor(msg_blue(i, j)/divider);
        
    end
end

% writing to the output image (encrypted)
imwrite(output, output_img);
clc;

disp(strcat('File - output(encrypted).png', ' saved at ', filepath));
imshow(output_img);
title('Encrypted image');
