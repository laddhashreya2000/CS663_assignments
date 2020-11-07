in_image = imread('newbird1.jpg'); 
% in_image = rgb2gray(in_image);
in_image = double(in_image);
[X,Y] = size(in_image); 
mask1 = [-1 0 1]; mask1 = [mask1;2*mask1;mask1]; 
mask2 = [1 0 -1]'; mask2 = [mask2,2*mask2,mask2];
out_image1 = imfilter(in_image,mask1); out_image2 = imfilter(in_image,mask2); 
out_image = sqrt(out_image1.*out_image1 + out_image2.*out_image2);
%out_image = uint8(out_image); imshow(out_image);
sig1 = 3; sig2 = 5;
alpha = 0.001;
d = 1+ceil(sqrt(-2*log(alpha))*sig2);
log_filt = fspecial('gaussian',2*d+1,sig1) - fspecial('gaussian',2*d+1,sig2);
LoG_image = imfilter(in_image,log_filt); %imshow(LoG_image);
param = 3;
cut_off = max(out_image(:))/param;
marr_image = zeros(X,Y);
for x = 2:(X-1)
    for y = 2:(Y-1)
        lr = sign(LoG_image(x,y-1)) ~= sign(LoG_image(x,y+1));
        ud = sign(LoG_image(x-1,y)) ~= sign(LoG_image(x+1,y));
        nwse = sign(LoG_image(x-1,y-1)) ~= sign(LoG_image(x+1,y+1));
        nesw = sign(LoG_image(x+1,y-1)) ~= sign(LoG_image(x-1,y+1));
        if ((lr|ud|nwse|nesw) == 1)&&((out_image(x,y) > cut_off))
            marr_image(x,y) = 1;
        end
    end
end
figure();
imshow(marr_image);
imwrite(marr_image,"edgebird1.jpg");
