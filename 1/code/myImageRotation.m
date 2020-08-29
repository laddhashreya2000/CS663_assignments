function out_image = myImageRotation(in_image)
    theta = pi/6; % define the angle of rotation
    R = [cos(theta),-sin(theta);sin(theta),cos(theta)];
    [M,N] = size(in_image); 
    centre = [ceil(M/2),ceil(N/2)];
    s = 2; %scalling factor(put natural number), to cover up the total image
    out_image = zeros(s*M,s*N);
    for j = 0:s*M
        for k = 0:s*N
            co_ord = R*([j,k]-s*centre)';
            x = co_ord(1); y = co_ord(2);
            if (abs(x)<=(centre(1)-1)) && (abs(y)<=(centre(2)-1))
                x = x + centre(1); y = y + centre(2);
                x2 = floor(x+1); x1 = floor(x); y2 = floor(y+1); y1 = floor(y);
                a11 = (x2-x)*(y2-y); a12 = (x2-x)*(y-y1); a21 = (x-x1)*(y2-y); a22 = (x-x1)*(y-y1);
                % applying the bilinear interpolation
                out_image(j,k) = a11*in_image(x1,y1)+a12*in_image(x1,y2)+a21*in_image(x2,y1)+a22*in_image(x2,y2);
            %elseif (abs(x) <= centre(1)) && (abs(y) <= centre(2))
                %out_image(j,k) = 255;
            end
        end
    end
    out_image = uint8(out_image);
    subplot(1,2,1); imshow(in_image); title('Original Image'); daspect([1 1 1]); colorbar;
    subplot(1,2,2); imshow(out_image); title('Rotated Image'); daspect([1 1 1]); colorbar;
end