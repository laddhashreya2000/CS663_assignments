%% MyMainScript
clc;
clear;
tic;
%% ORL using SVD

dir='../data/ORL/';

[train, test]=read_orl(dir);

K=[1,2,3,5,10,15,20,30,50,75,100,150,170];

rates1=myEigenSVD(train, test, K, 6, 4);

figure, plot(K, rates1)
xlabel('k'), ylabel('Recognition Rate'), title('ORL database- SVD');
ylim([0 100])

%% ORL using eig

K=[1,2,3,5,10,15,20,30,50,75,100,150,170];
rates2=myEigeneig(train, test, K, 6, 4);
figure, plot(K, rates2)
xlabel('k'), ylabel('Recognition Rate'), title('ORL database- EIG');
ylim([0 100])

%% YALE All eigencoefficients

path='../data/CroppedYale';

[train, test]=read_yale(path);

K = [1 2 3 5 10 15 20 30 50 60 65 75 100 200 300 500 1000];

rates=myEigeneig(train, test, K, 40, 20);

figure, plot(K, rates)
xlabel('k'), ylabel('Recognition Rate'), title('YALE database- Using all Eigen Values');
ylim([0 100])

%% 3 Removed
K=[5 10 15 20 30 50 60 65 75 100 200 300 500 1000];

rates=myEigeneigrem(train, test, K, 40, 20);

figure, plot(K, rates)
xlabel('k'), ylabel('Recognition Rate'), title('YALE database- Removing 3 Eigen Values');
ylim([0 100])
