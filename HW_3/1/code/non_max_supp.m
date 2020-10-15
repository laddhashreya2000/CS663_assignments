function out_image = non_max_supp(in_image)
    [X,Y] = size(in_image);
    out_image = in_image;
    for j = 2:X-1
        for k = 2:Y-1
            neighbour = [in_image(j-1,k-1:k+1),in_image(j+1,k-1:k+1),in_image(j,k-1),in_image(j,k+1)]; 
            M = max(neighbour);
            if in_image(j,k) < M
                out_image(j,k) = 0;
            end
        end
    end    
end