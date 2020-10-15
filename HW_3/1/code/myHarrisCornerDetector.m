function cor_image = myHarrisCornerDetector(in_image, sig_blur, sig_w, K)

    [X,Y] = size(in_image);
    in_image = double(in_image); in_image = in_image/max(in_image(:));
    in_image_disp = in_image; in_image = imgaussfilt(in_image,sig_blur); 
    mask1 = [-1 0 1]; mask1 = [mask1;2*mask1;mask1]; 
    mask2 = -[-1 0 1]'; mask2 = [mask2,2*mask2,mask2];
    out_image1 = imfilter(in_image,mask1); out_image2 = imfilter(in_image,mask2);
    subplot(1,2,1); imshow(out_image1); colormap jet; colorbar; title('Partial derivative along X axis');
    subplot(1,2,2); imshow(out_image2); colormap jet; colorbar; title('Partial derivative along Y axis');
    Ix2 = out_image1.*out_image1; Iy2 = out_image2.*out_image2; IxIy = out_image1.*out_image2;
    %%%%% parameters **************imshow(out_image)*********************
    alpha = 0.001;
    d = 1+ceil(sqrt(2)*sig_w*sqrt(-log(alpha))); %patch size is taken to be 2*d+1
    w = fspecial('gaussian',2*d+1,sig_w);
    %%%%% parameters ***********************************
    calc1 = imfilter(Ix2,w);
    calc2 = imfilter(Iy2,w);
    calc3 = imfilter(IxIy,w);
    eigens1 = zeros(X,Y); eigens2 = zeros(X,Y); C1 = zeros(X,Y); % for corner-ness measure
    for j = 1:X
        for k = 1:Y
            A = [calc1(j,k) calc3(j,k);calc3(j,k) calc2(j,k)];
            C1(j,k) = det(A) - K*((trace(A))^2);
            eigens = eig(A); eigens1(j,k) = eigens(1); eigens2(j,k) = eigens(2);
        end
    end
    figure();
    subplot(1,2,1); imshow(eigens1); colormap jet; colorbar; title('Other eigenvalue of the structure tensor');
    subplot(1,2,2); imshow(eigens2); colormap jet; colorbar; title('Principal eigenvalue of the structure tensor');
    C1 = non_max_supp(C1); thres = 0.05*max(C1(:));
    
%     figure(); 
%     C2 = (C1-min(C1(:)))/(max(C1(:))-min(C1(:)));
%     imshow(C2); colormap gray; colorbar; title('Harris "corner-ness" measure'); 
    
    figure();
    corners = double(C1>thres); cor_image = insert_marker(in_image_disp,corners);
    subplot(1,2,1); imshow(C1); colormap jet; colorbar; title('Harris corner-ness measure image'); 
    subplot(1,2,2); imshow(cor_image); colorbar; title('Corners on original image'); 
end

