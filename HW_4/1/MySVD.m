function [U,S,V] = MySVD(A)
    [m,n] = size(A); %x = min(m,n);
    mat_U = A*A'; mat_V = A'*A;
    %mat_U is mxm, mat_V is nxn 
    [U,D_U] = eig(mat_U); %both U and D_U are mxm 
    D_U_sum = sum(D_U,1); %We will sort the matrices U,D_U as per lardest eigen value first
    for j=1:m
        max_val = max(D_U_sum(j:m)); pos = D_U_sum == max_val;
        eig_vec_max = U(:,pos); U(:,pos) = U(:,j); 
        U(:,j) = eig_vec_max; D_U(j,j) = max_val;
        D_U_sum(pos) = D_U_sum(j); D_U_sum(j) = max_val; 
    end    
    [V,D_V] = eig(mat_V); %both V and D_V are nxn 
    D_V_sum = sum(D_V,1); %We will sort the matrices V,D_V as per lardest eigen value first
    for j=1:n
        max_val = max(D_V_sum(j:n)); pos = D_V_sum == max_val;
        eig_vec_max = V(:,pos); V(:,pos) = V(:,j); 
        V(:,j) = eig_vec_max; D_V(j,j) = max_val;
        D_V_sum(pos) = D_V_sum(j); D_V_sum(j) = max_val; 
    end    
    %Now both U,V are arranged such that the column vectors are arranged as
    %per decreasing singular value squared of D_U and D_V
    S = U'*A*V; %because U and V are orthonormal matrices, here the absolute values of S are correct
    %Now, the S matrix must only have non-negative entres
    %We will update V appropriately in order to correct the signs
    sign_correct = sum(S,1); sign_correct = sign_correct(sign_correct~=0);
    sign_correct = sign_correct./abs(sign_correct); len = size(sign_correct,2);
    V(:,1:len) = V(:,1:len).*repmat(sign_correct,n,1);
    S = U'*A*V;
end

