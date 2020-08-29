function out_image = myBilinearInterpolation(in_image)
    [M,N] = size(in_image);
    out_image = zeros(3*M-2,2*N-1);
    for j = 1:(3*M-2)
        for k = 1:(2*N-1)
            if (mod(j-1,3)==0)&&(mod(k-1,2)==0)
                out_image(j,k) = in_image((j+2)/3,(k+1)/2);
            end
        end
    end
    for j = 1:(3*M-2)
        for k = 1:(2*N-1)
            if (mod(j-1,3)==0)&&(mod(k-1,2)~=0)
                out_image(j,k) = (out_image(j,k-1)+out_image(j,k+1))/2;
            end
        end
    end
    for j = 1:(3*M-2)
        if mod(j-2,3) == 0
            out_image(j,:) = (2*out_image(j-1,:) + out_image(j+2,:))/3;
        elseif mod(j,3) == 0
            out_image(j,:) = (2*out_image(j+1,:) + out_image(j-2,:))/3;
        end
    end
    out_image = uint8(out_image);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]' ];
    subplot(1,2,1), imagesc(in_image); colormap (myColorScale);colormap jet;
    daspect ([1 1 1]); axis tight; colorbar;
    subplot(1,2,2); imagesc(out_image); colormap (myColorScale);colormap jet;
    daspect ([1 1 1]); axis tight; colorbar; 
end