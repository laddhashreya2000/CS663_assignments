in1_image=imread("maskflower.jpg");
in2_image=imread("edgebird.jpg");
in2_image=imresize(in2_image,0.5);
[X,Y]=size(in1_image);
[K,M]=size(in2_image);
for i=1:X
    for j=1:Y
        if (j<65)
            in1_image(i,j)=0;
        end
    end
 
end
imwrite(in1_image,"newbird1.jpg");

