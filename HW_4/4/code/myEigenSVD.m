function recog_rate=myEigenSVD(train, test, K, ntr, ntes)
%% Training
    [~,N]=size(train);

    %% Step 1: Mean

    xbar=sum(train, 2)/N;

    %% Step 2: Deduct Mean

    X=double(train)-repmat(xbar, [1,N]);

    %% Step 3 SVD

    [U,~,~] = svd(X);

    recog_rate=zeros(1,size(K,2));
    for k=1:size(K,2)
        %% Step 4 Eigenvectors of XX'
        W=U(:, 1:K(k));

        %% 6 Normalize V
        for col=1:K(k)
            W(:, col)=W(:, col)/norm(W(:, col));
        end

        %% 7 Project 

        alpha=(W')*X; % Eigen coefficient matrix

        %% Testing

        Z=double(test)-repmat(xbar, [1,size(test,2)]);

        alpha_test=(W')*Z;

        matches = 0;
        for i=1:size(alpha_test,2)
            dist = sum((alpha - repmat(alpha_test(:,i),[1,N])).^2, 1);
            idxm = find(dist == min(dist));
            if( floor((i-1)/ntes) == floor((idxm-1)/ntr) )
                matches = matches + 1;
            end
        end

        recog_rate(1,k)=matches/size(test,2)*100;
    end
end
    
    

