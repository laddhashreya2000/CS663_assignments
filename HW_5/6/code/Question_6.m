clear all; close all;
N = 201; centre = (N+1)/2; fac = (2*pi)/N;
X = -(N-1)/2:(N-1)/2; Y = -(N-1)/2:(N-1)/2;
lap1 = [0 1 0; 1 -4 1; 0 1 0];
lap2 = [-1 -1 -1; -1 8 -1; -1 -1 -1]; 
%% Computation for Laplacian kernel 1
my_ft_lap1 = zeros(N,N); 
for u = 1:N
    for v = 1:N
        my_ft_lap1(u,v) = 2*exp(-1i*fac*centre*(u+v))*(cos(fac*u)+cos(fac*v)-2);
    end
end
my_ft_lap1 = fftshift(my_ft_lap1);
figure();
imagesc(X,Y,mat2gray(log(1+abs(my_ft_lap1)))); colormap jet; colorbar; axis on;
title('Log magnitude plot of Laplacian kernel k_{1}'); pbaspect([1 1 1]);
figure();
surf(X,Y,log(1+abs(my_ft_lap1))); shading interp; colormap jet; colorbar;
title('Log magnitude surface plot of Laplacian kernel k_{1}'); pbaspect([1 1 1]);
%% Computation for Laplacian kernel 2
my_ft_lap2 = zeros(N,N); 
for u = 1:N
    for v = 1:N
        my_ft_lap2(u,v) = 2*exp(-1i*fac*centre*(u+v))*(4-cos(fac*u)-cos(fac*v)-cos(fac*(u+v))-cos(fac*(u-v)));
    end
end
my_ft_lap2 = fftshift(my_ft_lap2);
figure();
imagesc(X,Y,mat2gray(log(1+abs(my_ft_lap2)))); colormap jet; colorbar; axis on;
title('Log magnitude plot of Laplacian kernel k_{2}'); pbaspect([1 1 1]);
figure();
surf(X,Y,log(1+abs(my_ft_lap2))); shading interp; colormap jet; colorbar;
title('Log magnitude surface plot of Laplacian kernel k_{2}'); pbaspect([1 1 1]);

