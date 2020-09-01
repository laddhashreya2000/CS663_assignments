function out_img=myBicubicInterpolation(in_img)
    in_img= double(in_img);

    M_inv = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
             0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0;
             -3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0;
             2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0;
             0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0;
             0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0;
             -3,0,3,0,0,0,0,0,-2,0,-1,0,0,0,0,0;
             0,0,0,0,-3,0,3,0,0,0,0,0,-2,0,-1,0;
             9,-9,-9,9,6,3,-6,-3,6,-6,3,-3,4,2,2,1;
             -6,6,6,-6,-3,-3,3,3,-4,4,-2,2,-2,-2,-1,-1;
             2,0,-2,0,0,0,0,0,1,0,1,0,0,0,0,0;
             0,0,0,0,2,0,-2,0,0,0,0,0,1,0,1,0;
             -6,6,6,-6,-4,-2,4,2,-3,3,-3,3,-2,-1,-2,-1;
             4,-4,-4,4,2,2,-2,-2,2,-2,2,-2,1,1,1,1
             ];


    [j k c] = size(in_img); % Ray: Change
    %Specify the new image dimensions we want for our larger output image
    x_new = 3*j-2;
    y_new = 2*k-1;
    %Determine the ratio of the old dimensions compared to the new dimensions
    %Referred to as S1 and S2 in my tutorial
    x_scale = x_new./(j-1);
    y_scale = y_new./(k-1);

    % Change by Ray - Declare new output image here with c channels
    out_img = zeros(x_new, y_new, c);

    % Change by Ray - Now loop through each channel
    for z = 1 : c
        %Declare and initialize an output image buffer
        tmp_img = zeros(x_new,y_new);

        % New - Change by Ray.  Access the right channel
        I = in_img(:,:,z);

        Ix = double(zeros(j,k));
        for count1 = 1:j
            for count2 = 1:k
                if( (count2==1) || (count2==k) )
                    Ix(count1,count2)=0;
                else
                    Ix(count1,count2)=(0.5).*(I(count1,count2+1)-I(count1,count2-1));
                end
            end
        end

        Iy = double(zeros(j,k));
        for count1 = 1:j
            for count2 = 1:k
                if( (count1==1) || (count1==j) )
                    Iy(count1,count2)=0;
                else
                    Iy(count1,count2)=(0.5).*(I(count1+1,count2)-I(count1-1,count2));
                end
            end
        end

        Ixy = double(zeros(j,k));
        for count1 = 1:j
            for count2 = 1:k
                if( (count1==1) || (count1==j) || (count2==1) || (count2==k) )
                    Ixy(count1,count2)=0;
                else
                    Ixy(count1,count2)=(0.25).*((I(count1+1,count2+1)+I(count1-1,count2-1)) - (I(count1+1,count2-1)+I(count1-1,count2+1)));
                end
            end
        end

        for count1 = 0:x_new-1
            for count2 = 0:y_new-1
                 %Calculate the normalized distance constants, h and w
                 W = -(((count1./x_scale)-floor(count1./x_scale))-1);
                 H = -(((count2./y_scale)-floor(count2./y_scale))-1);
                 %Determine the indexes/address of the 4 neighbouring pixels from
                 %the source data/image
                 I11_index = [1+floor(count1./x_scale),1+floor(count2./y_scale)];
                 I21_index = [1+floor(count1./x_scale),1+ceil(count2./y_scale)];
                 I12_index = [1+ceil(count1./x_scale),1+floor(count2./y_scale)];
                 I22_index = [1+ceil(count1./x_scale),1+ceil(count2./y_scale)];
                 %Calculate the four nearest function values
                 I11 = I(I11_index(1),I11_index(2));
                 I21 = I(I21_index(1),I21_index(2));
                 I12 = I(I12_index(1),I12_index(2));
                 I22 = I(I22_index(1),I22_index(2));
                 %Calculate the four nearest horizontal derivatives
                 Ix11 = Ix(I11_index(1),I11_index(2));
                 Ix21 = Ix(I21_index(1),I21_index(2));
                 Ix12 = Ix(I12_index(1),I12_index(2));                  
                 Ix22 = Ix(I22_index(1),I22_index(2));
                 %Calculate the four nearest vertical derivatives
                 Iy11 = Iy(I11_index(1),I11_index(2));
                 Iy21 = Iy(I21_index(1),I21_index(2));
                 Iy12 = Iy(I12_index(1),I12_index(2));
                 Iy22 = Iy(I22_index(1),I22_index(2));
                 %Calculate the four nearest cross derivatives
                 Ixy11 = Ixy(I11_index(1),I11_index(2));
                 Ixy21 = Ixy(I21_index(1),I21_index(2));
                 Ixy12 = Ixy(I12_index(1),I12_index(2));
                 Ixy22 = Ixy(I22_index(1),I22_index(2));
                 %Create our beta-vector
                 beta = [I11 I21 I12 I22 Ix11 Ix21 Ix12 Ix22 Iy11 Iy21 Iy12 Iy22 Ixy11 Ixy21 Ixy12 Ixy22];

                 alpha = M_inv*beta';
                 temp_p=0;
                 for count3 = 1:16
                     w_temp = floor((count3-1)/4);
                     h_temp = mod(count3-1,4);

                     temp_p = temp_p + alpha(count3).*((1-W)^(w_temp)).*((1-H)^(h_temp));
                 end

                 tmp_img(count1+1,count2+1)=temp_p;
            end
        end

        % New - Change by Ray - Assign to output channel
        out_img(:,:,z) = tmp_img;
    end
    out_img = uint8(out_img);
    figure; 
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]' ];
    figure('Name','Bicubic Interpolation','NumberTitle','off')
    subplot(1,2,1), imagesc(in_img); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar;
    subplot(1,2,2); imagesc(out_img); colormap (myColorScale);colormap gray;
    daspect ([1 1 1]); axis tight; colorbar; 
    % imshow(out_img);
end