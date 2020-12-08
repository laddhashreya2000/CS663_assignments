function precise_score = precise_match(f,g)
%generate 6 scaled versions of g and take maximum among the 7 matches
    [M,N] = size(f); %f and g will have same size
    [dummy,precise_score] = matching_score(f,g,1); 
    fracs1 = [1.03 1.05 1.07];
    for j = 1:3
        g_resize = imresize(g,[M,round(fracs1(j)*N)]);
        N_res = size(g_resize,2); 
        g_resize = g_resize(:,round(N_res/2) - N/2:round(N_res/2) - 1 + N/2);
        [dummy, score] = matching_score(f,g_resize,1);
        precise_score = max(precise_score,score);
    end
    fracs2 = [0.93 0.95 0.97];
    for j = 1:3
        g_resize = imresize(g,[M,round(fracs2(j)*N)]);
        N_res = size(g_resize,2); 
        f_resize = f(:,N/2 - floor(N_res/2):floor(N_res/2) - 1 + N/2);
        g_resize = g_resize(:,1:2*floor(N_res/2));
        [dummy, score] = matching_score(f_resize,g_resize,1);
        precise_score = max(precise_score,score);
    end    
end
