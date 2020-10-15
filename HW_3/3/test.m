feat(:,:,1)=[1,1,2;1,4,5];
feat(:,:,2)=[3,4,6;8,6,3];
feat(:,:,3)=[4,3,7;3,66,88];

feat

feat_vec = reshape(feat,[],3)

orig=reshape(feat_vec, [2,3,3])

test=[1,1,2;1,4,5;33,44,66;88,66,33]
Y=[1,1,2;1,4,5];
[id, D]=knnsearch(test, Y, 'K', 3)

 index=knnsearch(feat_vec, x0, 'K', 100);

                rand_index = datasample(index, 30);

                sample=feat_vec(rand_index,:)

                for i = 1:size(sample, 1)

                    factor = exp(-((norm(sample(i,1:3)-x0(1:3))^2)/(2*(hr)^2)))*exp(-((norm(sample(i,4:5)- x0(4:5))^2)/(2*(hs)^2)));

                    den_sum=den_sum+factor;

                    add=sample(i,:)*factor;

                    sum=sum+add;
                end

                new=sum/den_sum;

                copy(x,y,1:3)=new(1:3);
            end
        end

        feat=copy;

    end

    feat

    %

    feat(isnan(feat))=0;

    out=uint8(feat(:,:,1:3));

    figure, imshow(out)

    in=imread("../data/baboonColor.png");
    % figure, imshow(in)
    in = double(in);

    blur = imgaussfilt(in,1);
    in = uint8(imresize(blur, 0.05));           
    figure, imshow(in)

    diff=abs(out-in)

    figure, imshow(255-diff)

    % 
    % figure, imshow(abs(out-in))

    % function out=myMeanShiftSegmentation(in_image)
    %     in_image = double(in_image); in_image = in_image/(max(max(in_image)));
    %     [X,Y] = size(in_image);
    %     sig = 1; %standard deviation of gaussian noise
    %     corr_image = in_image + sig*randn(size(in_image)); %adding noise to the image
    %         

