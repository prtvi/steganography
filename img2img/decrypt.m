% img2img - decrypt
% extracts hidden image from an encrypted image
clc;

input_img = input('Enter the full path to the encrypted image: ', 's');
[filepath, name, ext] = fileparts(input_img);

recovered_img = strcat(filepath, '\', 'recovered(decrypted).png');

% number of bits to shift
bits_to_shift = 4;
divider = power(2, bits_to_shift);

% read encrypted image
inputImage = imread(input_img);

% get dimensions of the image
dimensions = size(inputImage);
w = dimensions(1);
h = dimensions(2);

% init the 2D matrices which will store the pixel values of the images
r = zeros(w, h); g = zeros(w, h); b = zeros(w, h);

messageRecovered = zeros(w, h, 3, 'uint8');

for i = 1:w
    for j = 1:h
        
        % for red - accessing each pixel value, extracting its MSBs
        r(i, j) = inputImage(i, j, 1);
        messageRecovered(i, j, 1) = mod(r(i, j), divider)*divider;
             
        % for green - accessing each pixel value, extracting its MSBs
        g(i, j) = inputImage(i, j, 2);
        messageRecovered(i, j, 2) = mod(g(i, j), divider)*divider;
        
        % for blue - accessing each pixel value, extracting its MSBs
        b(i, j) = inputImage(i, j, 3);
        messageRecovered(i, j, 3) = mod(b(i, j), divider)*divider;
        
    end
end

% writing to output (decoded image)
imwrite(messageRecovered, recovered_img);
imshow(recovered_img);
title('Recovered (decrypted) image');
