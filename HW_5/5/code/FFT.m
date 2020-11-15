function [logf, inverse, row, col] = FFT(I, J)
    % using fftshift(fft2(I)) instead of fft2(I) doesn't make nay difference.
    f1 = fft2(I);
    f2 = fft2(J);
    % figure; imshow(f1);
    % figure; imshow(fftshift(f1));
    % figure; imshow(f2);
    fc2= conj(f2);
    num = f1.*fc2;
    product = f1.*f2;
    den = abs(product);
    % disp(den);
    res = num./den;
    % no conjugate of res needed. 
    logf = log(abs(res)+1);   
    fprintf("The logarithm is equal to %d. ", max(logf(:)));
    %we expect inverse DFT to be an impulse.
    inverse = ifft2(res);    
    [row, col] = find(inverse == max(inverse(:)));
    
    
end