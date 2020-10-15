function out_im = myMeanShiftSegmentation(in, num_iterations, hs, hr, knn)
    %% Blur image
    
    in = double(in);
    blur = imgaussfilt(in,1);
    in = imresize(blur, 0.5);
    [M,N,P] = size(in);

    %% Getting Features

    x_cord=zeros(M,N);
    for i=1:M
        x_cord(i,:)=i*ones(1,N);
    end

    y_cord=zeros(M,N);

    for j=1:N
        y_cord(:,j)=j*ones(1,M);
    end

    feat=in;
    feat(:,:,4)=x_cord;
    feat(:,:,5)=y_cord;         %Feat has desired 5D features
    
    %% Flattening Features
    
    feat_vec = reshape(feat,[],5);   % (M*N,5) matrix having rows as features. XY coordinates are 4,5
    
    %% Iterations
    scaled=feat_vec;
    scaled(:, 1:3)= feat_vec(:, 1:3)/(sqrt(2)*hr);   
    scaled(:, 4:5) = feat_vec(:, 4:5)/(sqrt(2)*hs);
    
    out=zeros(size(feat_vec));
    
    for n=1:num_iterations
    
        [index,D] = knnsearch(scaled, scaled, 'K', knn);
        
        for i=1:M*N
           
            w = exp(-(D(i,:).^2));
            den=sum(w);
            
            % Row-wise multiplication of feature vectors and corresponding weights
            w = repmat(w', 1, 3);
            out(i, 1:3) = sum(w.*(scaled(index(i,:),1:3)))/den;

        end
        scaled=out;
        fprintf('Iteration number %d\n', n);
    end
    
    % Out has scaled feature vector. Restore scale.
    out(:, 1:3)= out(:, 1:3)*sqrt(2)*hr;   
    out(:, 4:5) = out(:, 4:5)*sqrt(2)*hs;
    
    out_im=reshape(out(:,1:3), [M,N,3]);
    
end
   
               
    