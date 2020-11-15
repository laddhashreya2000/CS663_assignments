%% MyMainScript
clc;
clear;
tic;
%% ORL using SVD

dir='../data/ORL/';

[train, test_unknown, test_known]=read_orl(dir);

K=[1,2,3,5,10,15,20,30,50,75,90, 100,125, 150,160, 170];

[negatives, positives] =myRecog(train, test_unknown, test_known, K);
figure, plot(K, negatives)
xlabel('k'), ylabel('False negatives'), title('ORL database- SVD');
ylim([0 100])

figure, plot(K, positives)
xlabel('k'), ylabel('False positives'), title('ORL database- SVD');
ylim([0 100])

fprintf("At k=100, false negatives = %d . ", negatives(12)*100/128);
fprintf("At k=100, false positives = %d", positives(12)*100/80);