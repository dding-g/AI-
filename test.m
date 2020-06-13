clc;
clear all;

% Data를 가져온 url은 다음과 같습니다:
% https://kr.mathworks.com/matlabcentral/fileexchange/42770-logistic-regression-with-regularization-used-to-classify-hand-written-digits


% Xtrain, Xtest, ytrain, ytest 가져오기
load('./dataset_process/dataset/heartbeat_TrainTestData.mat');

% Xtrain 행렬의 크기를 가져오기 
% m은 sample 수
% n은 sample data 한개의 길이
[m, n]=size(Xtrain);
tol=1e-3;

Xtrain=[ones(length(Xtrain'(1,:)),1) Xtrain]; % Bias를 포함하기 위해서 1을 추가


%compute cost and gradient
iter=100; % No. of iterations for weight updation
  
theta=zeros(size(Xtrain,2),1); % Initial weights

alpha=0.01 % Learning rate

[th, train_loss, train_accuracy]=LR_SGD(theta, Xtrain, Ytrain, alpha, iter, tol); % Cost funtion
th

linear_h=[ones(size(Xtest,1),1) Xtest]*th; %target prediction
 
% probability calculation
[hp]=1./(1+exp(-linear_h)); % Hypothesis Function

ypred=zeros(size(hp));
ypred(hp>=0.5)=1;
ypred(hp<0.5)=0;

% 총 성공률. test set과 prediction set이 같으면1 다르면 0 이므로, 
% 해당 백터의 평균이 총 성공률이 됨.
test_accuracy = mean(Ytest==ypred) 
 

% Visual test
% Gray Image
figure;
plot(1:iter, train_accuracy, 1:iter, test_accuracy, 'LineWidth', 2);
grid on;
legend('train accuracy', 'test accuracy');
xlabel('epoch');
ylabel('Accuracy');

ypred(test_index)