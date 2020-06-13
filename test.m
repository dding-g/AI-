clc;
clear all;

% Data�� ������ url�� ������ �����ϴ�:
% https://kr.mathworks.com/matlabcentral/fileexchange/42770-logistic-regression-with-regularization-used-to-classify-hand-written-digits


% Xtrain, Xtest, ytrain, ytest ��������
load('./dataset_process/dataset/heartbeat_TrainTestData.mat');

% Xtrain ����� ũ�⸦ �������� 
% m�� sample ��
% n�� sample data �Ѱ��� ����
[m, n]=size(Xtrain);
tol=1e-3;

Xtrain=[ones(length(Xtrain'(1,:)),1) Xtrain]; % Bias�� �����ϱ� ���ؼ� 1�� �߰�


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

% �� ������. test set�� prediction set�� ������1 �ٸ��� 0 �̹Ƿ�, 
% �ش� ������ ����� �� �������� ��.
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