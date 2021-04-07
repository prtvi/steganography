% txt2img
% hides plain text inside of an image after setting a passkey
clear all;
clc;

% reading the image
input_image = input('Enter the full path to the image (cover): ', 's');
[filepath, name, ext] = fileparts(input_image);

img = imread(input_image);
size_f = size(img); h = size_f(1); w = size_f(2);

output_image = strcat(filepath, '/', 'output(encrypted).png');

% text to be hidden
input_text = input('Enter text to be hidden: ', 's');
% secret key
key = input('Enter a secret key: ', 's');

% concatenate key and input_text
text = strcat(key, '~', input_text, '`');

% convert characters into array with their corresponding ascii values
char_array = double(text);

% to convert text into stream of bits. " *8 " because every ascii value is represented in 8-bit representation
text_to_bits = zeros(1, length(char_array) * 8);

% loop to produce stream of bits from text
index = 1;
for i = 1:1:length(char_array)
    % converting every value in the char_array to its binary representation
    binary_repr = d2b(char_array(i));

    for j = 1:1:length(binary_repr)
        % from the binary representation, extracting each bit and inserting into text_to_bits
        text_to_bits(index) = binary_repr(j);
        index = index + 1;
    end
end

% number of bits from text
num_bits_from_text = index - 1;

% initialization of output image matrix
output = zeros(h, w, 3, 'uint8');

% reading pixel values from image and storing into output matrix
for i = 1:1:h
    for j = 1:1:w
        output(i,j,1) = img(i,j,1);
        output(i,j,2) = img(i,j,2);
        output(i,j,3) = img(i,j,3);
    end
end

% incorporating the hidden text into image
index = 1;
for i = 1:1:h
    for j = 1:1:w
        position = i + j;

        % if:
        % mod(position, 3) == 1 -----------> substitute in red pixel
        % mod(position, 3) == 2 -----------> substitute in green pixel
        % mod(position, 3) == 0 -----------> substitute in blue pixel

        if (index >= length(text_to_bits))
            break;
        end

        if (mod(position, 3) == 1)                                   
            pixel_selected = output(i, j, 1);             % red  
            
            % replacing the last bit with the bit from text_to_bits
            output(i, j, 1) = put_to_img(pixel_selected, text_to_bits, index);
            index = index + 1;

        elseif (mod(position, 3) == 2)                    
            pixel_selected = output(i, j, 2);             % green
            
            % replacing the last bit with the bit from text_to_bits
            output(i, j, 2) = put_to_img(pixel_selected, text_to_bits, index);
            index = index + 1;

        elseif (mod(position, 3) == 0)                    
            pixel_selected = output(i, j, 3);             % blue
            
            % replacing the last bit with the bit from text_to_bits
            output(i, j, 3) = put_to_img(pixel_selected, text_to_bits, index);
            index = index + 1;

        end
        
    end
end

% writing to the output image (encrypted)
imwrite(output, output_image);
clc;

disp(strcat('File - output(encrypted).png', ' saved at ', filepath));
imshow(output_image);
title('Encrypted image');
clear all;

% on an average, 1000 characters including spaces make up around 120 to 180 words
