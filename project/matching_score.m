function [peak_pos, match_score] = matching_score(f,g,band_limit)
    [m,n] = size(f); %assuming f,g of same size
    centre = [(m+1)/2,(n+1)/2]; % assuming both m,n are odd, otherwise extend f,g
    param2 = 0.55; param1 = 0.2;
    if band_limit == 1
        Km = floor(param1*m/2); Kn = floor(param2*n/2); 
    else
        Km = (m-1)/2; Kn = (n-1)/2;
    end
    F = fftshift(fft2(f)); G = fftshift(fft2(g));
    R_FG = (F.*conj(G))./abs(F.*conj(G));
    R_FG_K = R_FG(centre(1)-Km:centre(1)+Km,centre(2)-Kn:centre(2)+Kn); 
    r_fg_K = ifft2(ifftshift(R_FG_K)); abs_r_fg_K = abs(r_fg_K);
    %index1 = min(11,size(abs_r_fg_K,1)); index2 = min(11,size(abs_r_fg_K,2));
    %match_score = max(max(abs_r_fg_K(1:index1,1:index2))); 
    peak = max(abs_r_fg_K(:)); match_score = peak;
    [peak_pos_x,peak_pos_y] = find(abs_r_fg_K == peak);
    peak_pos = [peak_pos_x,peak_pos_y]-1;
end

