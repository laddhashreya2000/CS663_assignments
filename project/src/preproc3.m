function [outim, applicable]=preproc2(im)
    %% Final masked output is outmaskedfinal %%
    % Normalize

    %%Collect
%     close all;
% 
%     im=imread("test1.bmp");
%     figure, imshow(im)

    % 
    % [y0, x0]=getpts();
    % x0=round(x0);
    % y0=round(y0);

    %% Center
     im2 = mat2gray(im);
     c=irislocal1(im2);
     x0=c(1); 
     y0=c(2);

    %%
    % Consider ellipses here, theta=0
    % Get center [x0, y0]

    N=300;
    del1=1;
    del2=1;

    %% All possible l1, l2 values
    lmin=[0 0];
    lmax=[min(x0, size(im, 1)-x0)-del1-1, min(y0, size(im, 1)-y0)-del2-1];

    % Sval has all values over which we want to find min
    Sval=zeros(lmax(1,1), lmax(1,2));

    for i=1:lmax(1,1)
        for j=1:lmax(1,2)
            Sval(i,j)=obj(i, j, del1, del2, x0, y0, N, im);
        end
    end

    %%
    %To viz. cost
    % normal=abs(Sval)/(max(Sval,[],'all')-min(Sval,[],'all'));
    % figure, imshow(normal)

    %% Inner 

    %Global Min
    min_s=min(Sval,[],'all', 'linear');

    [l1,l2]=find(Sval==min_s);
    out=show_ellipse([l1,l2], x0, y0, im);
    %figure, imshow(out)

    %% Outer: l1=l2

    Sval1=min(lmax(1,1), lmax(1,2));

    for i=1:min(lmax(1,1), lmax(1,2))
        Sval1(i)=obj(i, i, del1, del2, x0, y0, N, im);
    end

    %To viz. cost
    %figure, plot(1:min(lmax(1,1), lmax(1,2)), Sval1)

    %Remove global min to enhance the 2nd lowest minima

    min_s=min(Sval1,[],'all', 'linear');

    lout=find(Sval1==min_s);
    
    %if(lout-15 <= 0) || (lout-15 >= 0)
    for i=max(1,lout-15):lout+15
        Sval1(i)=0;
    end
   

    min_s2=min(Sval1,[],'all', 'linear');
    l3=find(Sval1==min_s2);

    %figure, plot(1:min(lmax(1,1), lmax(1,2)), Sval1)

    out1=show_ellipse([l3,l3], x0, y0, im);
    %figure, imshow(out1)

    %% Normalize
    normim=zeros(128,256);

    for j=1:256
        ang=(pi*(j-128))/256;

        elin=[x0+l1*cos(ang), y0+l2*sin(ang)];
        elin_shift=[l1*cos(ang), l2*sin(ang)];

        ciin=[x0+l3*cos(ang), y0+l3*sin(ang)];

        step= (l3-norm(elin_shift))/128;

        for i=1:128
            r=norm(elin_shift)+i*step;
            pix=[x0+round(r*cos(ang)),y0+round(r*sin(ang))];
            normim(i,j)=im(pix(1,1),pix(1,2));
        end
    end

    %figure, imshow(uint8(normim))

    %% Eyelid mask
    
    masked=zeros(size(normim));
    for i=110:128
        for j=100:170
            if (normim(i,j)>170)
                masked(i,j)=1;
            end
        end
    end
    
    %figure, imshow(masked)

    %% Effective Region

    cropped=masked;
    xbound=0;

    for x=1:size(normim,1)
        if(sum(uint8(masked(x,:)))~=0)
            cropped(x,:)=ones(1,size(normim,2));
        else
            xbound=xbound+1;
        end 
    end

    croppedfinal=normim(1:xbound-10,:);
    
%        close all;
    %figure, imshow(uint8(croppedfinal))
    
    outim=croppedfinal;

end

%% S = n-point contour summation [float]
% [x0,y0]=center
% l1, l2 axes of ellipse
function Ssum = getS(l1, l2, x0, y0, N, im)
S=zeros(1,N);
for n=1:N
    element = im(x0+round(l1*cos((2*pi*n)/N)),y0+round(l2*sin((2*pi*n)/N)));
    S(1,n)=element;
end
Ssum=sum(S);
end

%% Objective function to minimize
function out = obj(l1, l2, del1, del2, x0, y0, N, im)
S1=getS(l1, l2, x0, y0, N, im);
S2=getS(l1+del1, l2+del2, x0, y0, N, im);
out=-abs(S1-S2); % - to maximize
end

%%

function out_im=show_ellipse(l, x0, y0, im)

l1=l(1);
l2=l(2);
max0=max(im, [], 'all');

for t=linspace(0,2*pi)
    x = round(l1*cos(t))+ x0 ;
    y = round(l2*sin(t))+ y0 ;
    im(x, y)=max0  ;
end
out_im=im;
end
