function out_image = myHE(in_image)
    [X,Y,Z] = size(in_image);
    in_image1 = in_image(:,:,1);
    in_image2 = in_image(:,:,2);
    in_image3 = in_image(:,:,3);
    out_image1 = zeros(X,Y); out_image2 = zeros(X,Y); out_image3 = zeros(X,Y);

    hist = zeros(1,256); cdf = zeros(1,256);
    for j = 0:255
        hist(j+1) = sum(sum(in_image1==j))/(X*Y); 
    end
    for j = 1:256
        cdf(j) = sum(hist(1:j));
    end
    for j = 1:X
        for k = 1:Y
            out_image1(j,k) = ceil(255*cdf(in_image1(j,k)+1));
        end
    end

    hist = zeros(1,256); cdf = zeros(1,256);
    for j = 0:255
        hist(j+1) = sum(sum(in_image2==j))/(X*Y); 
    end
    for j = 1:256
        cdf(j) = sum(hist(1:j));
    end
    for j = 1:X
        for k = 1:Y
            out_image2(j,k) = ceil(255*cdf(in_image2(j,k)+1));
        end
    end

    hist = zeros(1,256); cdf = zeros(1,256);
    for j = 0:255
        hist(j+1) = sum(sum(in_image3==j))/(X*Y); 
    end
    for j = 1:256
        cdf(j) = sum(hist(1:j));
    end
    for j = 1:X
        for k = 1:Y
            out_image3(j,k) = ceil(255*cdf(in_image3(j,k)+1));
        end
    end
    out_image(:,:,1)=out_image1;out_image(:,:,2)=out_image2;out_image(:,:,3)=out_image3;
    out_image = uint8(out_image);
    subplot(1,2,1); imshow(in_image);
    subplot(1,2,2); imshow(out_image);  
end