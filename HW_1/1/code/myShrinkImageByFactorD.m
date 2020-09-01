function out_image = myShrinkImageByFactorD(in_image,d) 
%the function shrinks the image 'in_image' by a factor of d
    [M,N] = size(in_image);
    out_image = zeros(floor(M/d),floor(N/d));
    for j = 1:floor(M/d)
        for k = 1:floor(N/d)
            out_image(j,k) = in_image(j*d,k*d);
        end
    end
    out_image = uint8(out_image);
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]' ];
end