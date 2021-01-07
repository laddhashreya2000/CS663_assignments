function matched = testing(im1,im2)
    f_eff = mat2gray(preproc3(im1)); g_eff = mat2gray(preproc3(im2)); close all;
    N_f = size(f_eff,1); N_g = size(g_eff,1); N_eff = min(N_f,N_g);
    f_eff = f_eff(1:N_eff,:); g_eff = g_eff(1:N_eff,:);
    %imshow(f_eff); figure; imshow(g_eff);
    match_thresh = 0.05; %only beyond this check for displacement and precise correction
    final_thresh = 0.1; %used in precise_match
    M = 128; N = 256;
    [f_al, g_al] = allign(f_eff,g_eff,match_thresh);
    %[peak_al, match_score_al] = matching_score(f_al,g_al,0);
    [dummy, match_score] = matching_score(f_al,g_al,1);
    %disp('Match Score = '); disp(match_score);
    if match_score >= match_thresh
        final_score = precise_match(f_al,g_al);
        %disp('Precise Match Score = '); disp(final_score);
        if final_score >= final_thresh
            matched = 1;
        else
            matched = 0;
        end
    else
        matched = 0;
    end
    
end