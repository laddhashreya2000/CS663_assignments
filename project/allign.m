function [f_out, g_out] = allign(f_in,g_in,threshold)
    [m,n] = size(f_in); %both f_in and g_in will have same size
    [peak_pos, match_score] = matching_score(f_in,g_in,0);
    %c1 = (m+1)/2; c2 = (n+1)/2;
    if match_score > threshold
        %figure(); imshow(f); %figure(); imshow(g);
        G = fftshift(fft2(g_in));
        x_o = peak_pos(1); y_o = peak_pos(2);
        G_new = zeros(m,n);
        for j = 1:m
            for k = 1:n
                G_new(j,k) = G(j,k)*exp(-2*pi*1i*((j*x_o/m)+(k*y_o/n)));
            end
        end
        g_new = ifft2(ifftshift(G_new)); %figure(); imshow(mat2gray(abs(g_new)));
        if peak_pos(1) > m/2
            g_out = g_new(1:end-(m-peak_pos(1)),:);
            f_out = f_in(1:end-(m-peak_pos(1)),:);
        else
            g_out = g_new(peak_pos(1)+1:end,:);
            f_out = f_in(peak_pos(1)+1:end,:);  
        end

        if peak_pos(2) > n/2
            g_out = g_out(:,1:end-(n-peak_pos(2)));
            f_out = f_out(:,1:end-(n-peak_pos(2)));  
        else
            g_out = g_out(:,peak_pos(2)+1:end);
            f_out = f_out(:,peak_pos(2)+1:end);  
        end    
        g_out = mat2gray(abs(g_out)); f_out = mat2gray(abs(f_out));
    else
        f_out = f_in;
        g_out = g_in;
    end
end

