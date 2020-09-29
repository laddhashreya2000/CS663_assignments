function [out_image, corrupted] = myPatchBasedFiltering(in_image, windowsize, patchsize, sigma)
    
    input = in_image;
%     figure, imshow(input),  title('Original'), colormap(myColorScale), colorbar, daspect([1 1 1]);
    % noisy image
    s = 0.05 * (max(input(:))-min(input(:)));
    [M,N] = size(input);
    noise = normrnd(0,s,M,N);
    input = input + noise;
    corrupted = input;
%     figure, imshow(input),  title('noisy'), colormap(myColorScale), colorbar, daspect([1 1 1]);
    
    % window and patch size
    p = floor((patchsize-1)/2);
    w = floor((windowsize-1)/2);
%     count = 0;
%     loop = 0;
    s2 = 1.5;
    [x,y] = meshgrid((-p:p), (-p:p));
    gaussian = exp(-(x.^2 + y.^2)/(2*s2^2));
%     disp(gaussian(p+1,p+1));
    out_image = double(zeros(M,N));

    for i = 1:M
        patch_mini = max(1,i-p);
        patch_maxi = min(i+p, M);
        window_mini = max(1,i-w);
        window_maxi = min(i+w, M);
        
%         disp(patch_mini);
%         disp(patch_maxi);
        for j=1:N
%             count = count + 1;
%             disp(count);
            patch_minj = max(1,j-p);
            patch_maxj = min(j+p, N);
            window_minj = max(1,j-w);
            window_maxj = min(j+w, N);
            
            % current patch image with index starting from 1
            current = input(patch_mini:patch_maxi, patch_minj:patch_maxj);
%             disp(size(current));
%             disp(current);
            % define the gaussian mask to make patches isotropic
            current = current .* gaussian((p+1+patch_mini-i:p+1+patch_maxi-i), (p+1+patch_minj-j:p+1+patch_maxj-j));
            image = zeros(patchsize, patchsize);
            for k = patch_mini:patch_maxi
                for l = patch_minj:patch_maxj
                    image(p+1+k-i, p+1+l-j) = current(k-patch_mini+1,l-patch_minj+1);
                end
            end
%             disp(image);
%             disp(size(image));
            %find weights for current window
            weights = zeros([window_maxi - window_mini + 1, window_maxj - window_minj + 1]);
            
            for window_i = window_mini:1:window_maxi
                other_mini = max(1,window_i-p);    
                other_maxi = min(window_i+p, M);
                
                for window_j = window_minj:1:window_maxj
%                     loop = loop+1;
%                     disp(loop);
                    other_minj = max(1,window_j-p);    
                    other_maxj = min(window_j+p, N);
                    
                    other = input(other_mini:other_maxi, other_minj:other_maxj);
                    other = other .* gaussian((p+1+other_mini-window_i:p+1+other_maxi-window_i), (p+1+other_minj-window_j:p+1+other_maxj-window_j)); 

                    image2 = zeros(patchsize, patchsize);
                    for k = other_mini:other_maxi
                        for l = other_minj:other_maxj
                            image2(p+1+k-window_i, p+1+l-window_j) = other(k-other_mini+1,l-other_minj+1);
                        end
                    end
%                     disp(image2);

                    % weights calculation for a single pixel
                    weights(window_i - window_mini + 1, window_j - window_minj + 1) = exp(-sum(sum((image - image2) .^ 2))/sigma^2);
                end
            end
          
            % center pixel intensity
            out_image(i,j) = sum(sum(weights .* input(window_mini:window_maxi, window_minj:window_maxj)))/sum(sum(weights));
        end
    end
end
