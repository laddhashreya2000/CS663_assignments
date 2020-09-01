function out_image = myHE(in_image)
    [X,Y,Z] = size(in_image);

    for i= 1:Z
        in_img= in_image(:,:,i);
        out_img=zeros(X,Y);
        hist = zeros(1,256); cdf = zeros(1,256);
        for j = 0:255
            hist(j+1) = sum(sum(in_img==j))/(X*Y); 
        end
        for j = 1:256
            cdf(j) = sum(hist(1:j));
        end
        for j = 1:X
            for k = 1:Y
                out_img(j,k) = ceil(255*cdf(in_img(j,k)+1));
            end
        end
        out_image(:,:,i)=out_img;
    end
    
    out_image = uint8(out_image);
%     subplot(1,2,1); imshow(in_image);
%     subplot(1,2,2); imshow(out_image);  
end