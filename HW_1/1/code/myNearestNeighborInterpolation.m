function out_image = myNearestNeighborInterpolation(in_image)
    [M,N] = size(in_image);
    X = 3*M - 2;
    Y = 2*N - 1;
    out_image = zeros(X,Y);
    row_scale = X / M;
    col_scale = Y / N;

    for j = 1:X
        row = round(j/row_scale);
        if(row<1)
           row = 1;
        end
        for k = 1:Y
            col = round(k/col_scale);
            if(col<1)
                col = 1;
            end
            out_image(j,k) = in_image(row, col);
        end
    end
    out_image = uint8(out_image);
end
