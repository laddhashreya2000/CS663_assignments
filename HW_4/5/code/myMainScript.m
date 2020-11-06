%% MyMainScript
tic;
%% Your code here
K = 180; %total number of eigen faces we consider
persons = 32; images = 6; %considering first 32 persons and first 6 images of each in ORL
[X_avg, U_cap, alpha_svd, V_pca_cap, alpha_pca] = SVD_PCA_ORL(K,persons,images);
%in the above function the values regarding the PCA method and SVD method are obtained
eig_face_and_recon(X_avg,U_cap,alpha_svd,V_pca_cap,alpha_pca)
%above function shows the image reconstruction and eigen faces
toc;
