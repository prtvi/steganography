function a = b2d(list)
    % converts binary to decimal
    % appends extra zeroes to smaller than 8-bit binary representations
    
    j = length(list);
    li = zeros(1, j);
    for i = 1:1:length(list)
        li(i) = list(j);
        j = j-1;
    end
    a = bi2de(li);   
    
end