% txt2img
% extracts hidden text from encrypted image after the correct key is entered
clear all;
clc;

% reading the images
input_image = input('Enter the full path to the image (for extraction): ', 's');
img = imread(input_image);

% extracting the dimensions of the image
size_f = size(img); h = size_f(1); w = size_f(2);

% individual last bits from image pixels
% creating a stream of bits, accessing the last bits of the selected pixels
indi_bits_for_text = zeros(1, h*w);

% extracting the last bit from the pixels
index = 1;
for i = 1:1:h
    for j = 1:1:w
        position = i + j;
        
        val = 0;
        if (mod(position, 3) == 1)                       % red
            val = img(i, j, 1);

        elseif (mod(position, 3) == 2)                   % green
            val = img(i, j, 2);

        elseif (mod(position, 3) == 0)                   % blue
            val = img(i, j, 3);

        end

        % selecting the pixel and converting its value to binary
        val_bin = d2b(val);
        % inserting the last bit from that 8 binary representation into indi_bits_for_text
        indi_bits_for_text(index) = val_bin(length(val_bin));
        index = index + 1;
        
    end
end

% converting the stream of bits into characters then into a string
key = '';
hidden_text = '';
index = 1;
for i = 1:8:length(indi_bits_for_text)
    li = zeros(1, 8);
    % forming the character using every 8 bits from indi_bits_for_text
    for j = 1:1:8
        li(j) = indi_bits_for_text(index);
        index = index + 1;
    end

    % converting binary seq to decimal then converting to character
    ch = get_char(li);

    % looking for special end character to terminate the process
    if (strcmp(ch, '`'))
        break;
    end

    % looking for '~' to get the key
    if (strcmp(ch, '~'))
        key = hidden_text;
    end

    if (strcmp(ch, ' '))
        hidden_text = strcat(hidden_text, {' '});
    end

    % appending each character to the final text
    hidden_text = strcat(hidden_text, ch);
end


% converting chars to strings
key = convertCharsToStrings(key);
hidden_text = convertCharsToStrings(hidden_text);

% chopping off the secret key from text from the beginning
final_text = extractAfter(hidden_text, '~');

run = 1;
while (run)
    entered_key = input('Enter the secret key: ', 's');

    if (strcmp(key, entered_key))
        clc;
        disp('Decrypted hidden text: ');
        disp(final_text);
        run = 0;
    else
        disp('Incorrect key');
        continue;
    end
    
end
