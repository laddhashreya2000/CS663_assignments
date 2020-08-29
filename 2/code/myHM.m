function out_image = myHM(in_image, ref_image)
[X,Y,Z] = size(in_image); % we have assumed that the in and ref image has same sizes
out_image = zeros(X,Y,Z);

hist = zeros(3,256); cdf = zeros(3,256);
for j = 0:255
    hist(:,j+1) = [sum(sum(in_image(:,:,1)==j)),sum(sum(in_image(:,:,2)==j)),sum(sum(in_image(:,:,3)==j))]';
end
hist = hist/(X*Y);
for j = 1:256
    cdf(:,j) = sum(hist(:,1:j),2);
end

hist_ref = zeros(3,256); cdf_ref = zeros(3,256);
for j = 0:255
    hist_ref(:,j+1) = [sum(sum(ref_image(:,:,1)==j)),sum(sum(ref_image(:,:,2)==j)),sum(sum(ref_image(:,:,3)==j))]';
end
hist_ref = hist_ref/(X*Y);
for j = 1:256
    cdf_ref(:,j) = sum(hist_ref(:,1:j),2);
end

for j = 1:X
    for k = 1:Y
        a(1) = cdf(1,in_image(j,k,1)+1); a(2) = cdf(2,in_image(j,k,2)+1); a(3) = cdf(3,in_image(j,k,3)+1);
        choose1 = sum(cdf_ref(1,:)<=a(1)); choose2 = sum(cdf_ref(2,:)<=a(2)); choose3 = sum(cdf_ref(3,:)<=a(3));      
        out_image(j,k,:) = [choose1;choose2;choose3];
    end
end
out_image = uint8(out_image);
eq_image = myHE(in_image);
figure;
subplot(1,3,1); imshow(in_image); title('Original Image'); 
subplot(1,3,2); imshow(out_image); title('Histogram Matched Image');
subplot(1,3,3); imshow(eq_image); title('Histogram Equalized Image');
end



