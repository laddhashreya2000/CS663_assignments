im=imread("../data/barbaraSmall.png");

bilinear0=myBilinearInterpolation(im);
part_bilinear=bilinear0(1:120, 120:end);

Nearest0=myNearestNeighborInterpolation(im);
part_nearest = Nearest0(1:120, 120:end);

bicubic0=myBicubicInterpolation(im);
part_bicubic=bicubic0(1:120, 120:end);

figure('Name','Comparison','NumberTitle','off')
subplot(1,2,1), imagesc(part_bilinear); title('Bilinear');
daspect([1 1 1]);
subplot(1,2,2), imagesc(part_nearest); title('Nearest Neighbour');
subplot(1,2,3), imagesc(part_bicubic); title('Bicubic');
daspect([1 1 1]);

colormap jet;  
daspect([1 1 1]);
% colorbar;

