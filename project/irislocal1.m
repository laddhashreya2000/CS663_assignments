function [c,mask] = irislocal1(in_img)
    [M,N] = size(in_img);
    threshold = 0.25; mean_val = mean(in_img(:));
    img_bin = zeros(M,N);
    for j=1:M
        for k=1:N 
            if in_img(j, k) <= threshold*mean_val 
             img_bin(j, k) = 1; 
            end
        end
    end
    mat_m = [1:M]'; mat_m = repmat(mat_m,1,N);
    mat_n = [1:N]; mat_n = repmat(mat_n,M,1);
    c_m = round(sum(sum(mat_m.*img_bin))/sum(img_bin(:)));
    c_n = round(sum(sum(mat_n.*img_bin))/sum(img_bin(:)));
    
    r_init = 60; delta_r = 5; mask = zeros(M,N);
    
    while(true)
        r = r_init - delta_r;
        for j = 1:M
            for k = 1:N
                if (j-c_m)^2 + (k-c_n)^2 <= r^2
                    mask(j,k) = 1;
                end
            end
        end
        img_bin_mask = mask.*img_bin;
        mat_m = (1:M)'; mat_m = repmat(mat_m,1,N);
        mat_n = (1:N); mat_n = repmat(mat_n,M,1);
        c_m_new = round(sum(sum(mat_m.*img_bin_mask))/sum(img_bin_mask(:)));
        c_n_new = round(sum(sum(mat_n.*img_bin_mask))/sum(img_bin_mask(:)));  
        if(c_m_new == c_m)&&(c_n_new == c_n)
            break
        end
        c_m = c_m_new; c_n = c_n_new;
    end
    mask = mask.*img_bin;
    c = [c_m,c_n];
end

%trial code
% in_img = imread('eye1.bmp');
% in_img = mat2gray(in_img);
% [c,mask] = irislocal1(in_img);
% figure; imshow(mask);
% im = insertMarker(in_img,[c(2),c(1)],'x','color','red','size',10);
% figure;
% imshow(im);