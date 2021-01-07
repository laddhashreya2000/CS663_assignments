function [total_neg, total_pos] = myRecog(train, test_unknown, test_known, K)
%% Training
    [~,N]=size(train);

    %% Step 1: Mean

    xbar=sum(train, 2)/N;
%     disp(size(xbar));
    %% Step 2: Deduct Mean

    X=double(train)-repmat(xbar, [1,N]);

    %% Step 3 SVD

    [U,~,~] = svd(X, 0);

    total_neg=zeros(1,size(K,2));
    total_pos = zeros(1, size(K,2));
    for k=1:size(K,2)
        %% Step 4 Eigenvectors of XX'
        W=U(:, 1:K(k));

        %% 6 Normalize V
        for col=1:K(k)
            W(:, col)=W(:, col)/norm(W(:, col));
        end

        %% 7 Project 

        alpha=(W')*X; % Eigen coefficient matrix

        %% Threshold
        
        deviation_per_person = zeros(32,1); % Deviation from eigencoefficient per person

        for i=1:32
            for j=1:5
                for m=j+1:6
                    if norm(alpha(:,(i-1)*6+j) - alpha(:,(i-1)*6+m)) > deviation_per_person(i)
                        deviation_per_person(i) = norm(alpha(:,(i-1)*6+j) - alpha(:,(i-1)*6+m));
                    end
                end        
            end
        end
        
        thres_devn = 0.831*min(deviation_per_person);
        if(K(k)==100)
            fprintf("The threshold value at k = 100 is %d .", thres_devn);
        end
        %% Testing - False negatives

        Z=double(test_known)-repmat(xbar, [1,size(test_known,2)]);

        alpha_test=(W')*Z;
%         matches = 0;
        min_dist = norm(alpha_test - alpha(:,1));
%         matches = 0;
        false_neg = 0;
        for i=1:size(alpha_test,2)
            for m = 2:N
                if norm(alpha_test(i) - alpha(:,m)) < min_dist
                    min_dist = norm(alpha_test(i) - alpha(:,m));
                end
            end
            if min_dist > thres_devn
                false_neg = false_neg + 1;
            end
        end
        total_neg(1,k) = false_neg;
        
        %% Testing - False positives
        Z2=double(test_unknown)-repmat(xbar, [1,size(test_unknown,2)]);

        alpha_test2=(W')*Z2;
%         matches = 0;
        min_dist = norm(alpha_test2 - alpha(:,1));
%         matches = 0;
        false_pos = 0;
        for i=1:size(alpha_test2,2)
            for m = 2:N
                if norm(alpha_test2(i) - alpha(:,m)) < min_dist
                    min_dist = norm(alpha_test2(i) - alpha(:,m));
                end
            end
            if min_dist < thres_devn
                false_pos = false_pos + 1;
            end
        end
        total_pos(1,k) = false_pos;
    end
end
    
    

