function matrix = threshold(matrix,thr)
    for i = 1:size(matrix)
        for j = 1:size(matrix)
            if matrix(i,j)> thr
                matrix (i,j) = 1;
            else
                matrix(i,j) = 0;
            end
        end
    end
end

