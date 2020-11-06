function eig_face_and_recon(X_avg,U_cap,alpha_svd,V_pca_cap,alpha_pca)
    %Plotting of the eigen faces and the reconstruction of images
    a = 112; b = 92; K = [2; 10; 20; 50; 75; 100; 125; 150; 175];
    image_number = 46;
    figure(); sgtitle('Reconstruction of 8th Person 4th Image(SVD method)');
    for iter = 1:9
        x_approx = X_avg + U_cap(:,1:K(iter))*alpha_svd(1:K(iter),image_number); 
        image_approx = zeros(a,b);
        for j = 1:b
            image_approx(:,j) = x_approx((j-1)*a+1:j*a);
        end
        image_approx = image_approx/max(image_approx(:));
        subplot(3,3,iter)
        imshow(image_approx);
    end
    figure(); sgtitle('Eigen Faces for SVD method');
    faces = 25;
    for k = 1:faces
        eig_face = zeros(a,b);
        for j = 1:b
            eig_face(:,j) = U_cap((j-1)*a+1:j*a,k);
        end
        eig_face = (eig_face-min(eig_face(:)))/(max(eig_face(:))-min(eig_face(:)));
        subplot(5,5,k)
        imshow(eig_face);        
    end

    %above eigen faces for PCA method using V_pca_cap
    image_number = 69;
    figure(); sgtitle('Reconstruction of 12th Person 3rd Image(PCA method)');
    for iter = 1:9
        x_approx = X_avg + V_pca_cap(:,1:K(iter))*alpha_pca(1:K(iter),image_number); 
        image_approx = zeros(a,b);
        for j = 1:b
            image_approx(:,j) = x_approx((j-1)*a+1:j*a);
        end
        image_approx = image_approx/max(image_approx(:));
        subplot(3,3,iter)
        imshow(image_approx);
    end
    figure(); sgtitle('Eigen Faces for PCA method');
    faces = 25;
    for k = 1:faces
        eig_face = zeros(a,b);
        for j = 1:b
            eig_face(:,j) = V_pca_cap((j-1)*a+1:j*a,k);
        end
        eig_face = (eig_face-min(eig_face(:)))/(max(eig_face(:))-min(eig_face(:)));
        subplot(5,5,k)
        imshow(eig_face);        
    end
end