function out_image = myForegroundMask(in_image)
    [M,N] = size(in_image);
    mask = zeros(M,N);
    out_image = zeros(M,N);
    
    %threshold is 12 after hit and trial
    for i=1:M
        for j=1:N
            if(in_image(i,j)>=12)
                mask(i, j) = 255;
            else
                mask(i,j) = 0;
            end
            out_image(i,j) = in_image(i,j)*(mask(i,j)/255);
        end
    end
    out_image = uint8(out_image);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]' ];
    subplot(1,3,1), imagesc(in_image); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar;
    subplot(1,3,2); imagesc(mask); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar; 
    subplot(1,3,3); imagesc(out_image); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar; 
end
