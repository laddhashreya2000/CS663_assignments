%% MyMainScript

tic;
%% Your code here
close all;
im=imread('../data/flower.jpg');


%im=imadjust(im,stretchlim(im),[0,1]);

figure, imshow(im)

[x0,y0]=getpts;
x0=round(x0/2);
y0=round(y0/2);
% Point of interest
poi=[y0,x0];

intensity_thresh=20;

hs=20;
hr=40;
knn=1000;
num_iter=20;
%out=myMeanShiftSegmentation(im, num_iter, hs, hr, knn);

[M, N, P]=size(out);
bin_mask=zeros(M,N);

for i=1:M
    for j=1:N
        
        d=norm(reshape(out(y0,x0,:), [1,3])-reshape(out(i,j,:), [1,3]));
        if(d<intensity_thresh)
            bin_mask(i,j)=255;
        end
    end
end

% figure, imshow(uint8(bin_mask))

cc = bwconncomp(bin_mask);

mask=zeros(M,N);
find=0;
for i=1:size(cc.PixelIdxList,2)
    [row, column] = ind2sub([M,N], cc.PixelIdxList{1,i});
    final_index=[row, column];
    for j=1:size(final_index,1)
        if (final_index(j,1)==y0 && final_index(j,2)==x0)
            mask(final_index)=255;
            find=1;
            break;
        end
    end
    
    if find==1
        break
    end 
end
    
mask = imfill(mask,'holes');
figure, imshow(mask)

toc;
