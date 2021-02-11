
countred = 0;
countgreen = 0;
countblue = 0;

h = 440;
w = 500;

for i=1:1:h
    for j = 1:1:w
        pos = i + j;
        if (mod(pos, 3) == 1)
            countred = countred + 1;
        elseif (mod(pos, 3) == 2)
            countgreen = countgreen + 1;
        else (mod(pos, 3) == 0)
            countblue = countblue + 1;
        end
    end
end

disp(countred + countgreen + countblue);
