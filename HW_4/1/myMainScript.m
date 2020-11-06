%% MyMainScript
clear all;
tic;
%% Your code here
% we will see the implementation of MySVD for 3 different examples
A = [1 2 3; 2 3 1; 5 4 9; 9 4 11];
[U,S,V] = MySVD(A); 
disp('Singular value matrix is:')
round(S,3)
disp('The value of U*S*V_t is')
U*S*V'
if (round(U*S*V',3) == A)
	disp('The decomposition of A is correct');
else
	disp('The decomposition of A is incorrect');
end

B = [11 4 58 32; 29 3 6 81; 5 4 49 1; 92 41 11 2];
[U,S,V] = MySVD(B); 
disp('Singular value matrix is:')
round(S,3)
disp('The value of U*S*V_t is')
U*S*V'
if (round(U*S*V',3) == B)
	disp('The decomposition of B is correct');
else
	disp('The decomposition of B is incorrect');
end
toc;
