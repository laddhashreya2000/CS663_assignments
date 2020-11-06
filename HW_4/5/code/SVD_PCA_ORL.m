function [X_avg, U_cap, alpha_svd, V_pca_cap, alpha_pca] = SVD_PCA_ORL(num_basis,persons,images)
%Provide the imput for number of persons and images per person and number 
%of columns(num_basis) to be preserved
%using SVD method
a = 112; b = 92; d = a*b; N = persons*images; 
X = zeros(d,0); %matrix to store image data in vectorized form
mydir  = pwd; idcs   = strfind(mydir,'\');
newdir = mydir(1:idcs(end)-1); BaseName = strcat(newdir,'\images\ORL\s');
for j = 1:persons
    cd(BaseName+string(j));
    for k = 1:images
        im = imread(string(k)+'.pgm');
        %figure();
        %imshow(im);
        vec = zeros(0,0);
        for col = 1:b
            vec(end+1:end+a) = im(:,col); 
        end
        X(:,end+1) = vec';
    end
end
X_avg = sum(X,2)/N; X_avg = repmat(X_avg,1,N); X_bar = X-X_avg;
%we will find out the svd of X_bar
[U,S,V] = svd(X_bar);
U_cap = U(:,1:num_basis);
alpha_svd = U_cap'*X_bar;

%applying algorithm for PCA method
L = X_bar'*X_bar;
[W,Gamma] = eig(L); %sorted eigen values
[d,ind] = sort(diag(Gamma),'descend');
Gamma = Gamma(ind,ind);
W = W(:,ind);
V_pca = X_bar*W; V_pca_norm = sum(V_pca.*V_pca,1); V_pca_norm = sqrt(V_pca_norm);
V_pca = V_pca./repmat(V_pca_norm,size(V_pca,1),1); 
V_pca_cap = V_pca(:,1:num_basis); 
alpha_pca = V_pca_cap'*X_bar;
X_avg = X_avg(:,1);
cd(mydir);
end