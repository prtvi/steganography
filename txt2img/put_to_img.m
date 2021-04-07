function modified_pixel_value = put_to_img(pixel_selected, text_to_bits, index)
    % modifies the last bit of a given integer by replacing with the bit from 'text_to_bits'
    
    val_bin = d2b(pixel_selected);

    % selecting the last bit from text_to_bits
    last_bit = text_to_bits(index);

    % setting the last bit of 'val_bin' as required in the binary repr of 'val'
    val_bin(length(val_bin)) = last_bit;

    % replacing the modidfied pixel value
    modified_pixel_value = b2d(val_bin);

end