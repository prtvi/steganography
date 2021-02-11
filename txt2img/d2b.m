function list = d2b(num)
    % converts decimal to binary and reverses it
    % appends extra zeroes to smaller than 8-bit binary representations

    bin = de2bi(num);
    N = length(bin);

    if(N<8)
        for i = N+1:1:8
            bin(i) = 0;
        end
    end

    n = 8;
    list = zeros(1, 8);
    for j = 1:1:8
        list(j) = bin(n);
        n = n - 1;
    end

end