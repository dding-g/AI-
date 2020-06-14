clc;
clear all;

% test_accuracy가 제일 높은 모델이 가장 좋은 모델이다.

% Xtrain, Xtest, Ytrain, ytest 가져오기
load('./dataset_process/dataset/heartbeat_TrainTestData.mat');

% number of classes 
k=3;


% data를 보기위한 함수 및 준비
%sel = randperm(size(Xtrain, 1));
%sel = sel(1:100);
%displayData(Xtrain(sel, :)); 

m_train = size(Xtrain,1); % train 과 test의 크기가 다름
m_test = size(Xtest,1);

Xtrain=[ones(m_train,1) Xtrain]; % Bias를 포함하기 위해서 1을 추가
Xtest =[ones(m_test,1) Xtest];

n = size(Xtrain,2); 

%compute cost and gradient
iter=500; % Number of epoch

% Initial weights
% 이렇게 하면 매번 초기값이 바뀌기 때문에 더 좋은 세타를 만날 수도 있다.
theta=0.01*randn(n,k); 
% Learning rate
alpha=1e-5 % alpha 가 작아지면 정확도는 높아지나, epoch을 더 높여줘야한다. 학습 속도가 느리기 때문
% Regularization coefficient
lambda=0; 

% to save optimized thetas
th=zeros(n,k,iter); % 이렇게 하면 3차원 (1,2) 이렇게 하면 2차원
% save values
% 미리 메모리를 잡아놈. 그렇지 않으면 속도가 느려지기 때문. 
train_loss=zeros(1,iter);
test_loss=zeros(1,iter);
train_accuracy=zeros(1,iter);
test_accuracy=zeros(1,iter);
ypred = zeros(m_test,iter);

for epoch=1:iter
  epoch
  %[th(:,:,epoch), train_accuracy(epoch), train_loss(epoch)]=MLR_SGD(theta, Xtrain, Ytrain, alpha); % Cost funtion
  [th(:,:,epoch), train_accuracy(epoch), train_loss(epoch)]=MLR_SGD_reg(theta, Xtrain, Ytrain, alpha, lambda); % Cost funtion
  [ypred(:,epoch), test_accuracy(epoch), test_loss(epoch)]=MLR_test(Xtest, Ytest, th(:,:,epoch));
  theta = th(:,:,epoch);
endfor



%hold on;
figure;
plot(1:iter, train_loss, 1:iter, test_loss, 'LineWidth', 2); %plot 2개를 한번에 보여주기기
grid on;
legend('train loss', 'test loss');
xlabel('epoch');
ylabel('Loss');

%test_accuracy 가 더이상 높아지지 않는다면, 모델의 한계일 수도 있다.
%혹은 overffiting이 되었거나. 이때는 regularization를 켜서 확인한다.
figure;
plot(1:iter, train_accuracy, 1:iter, test_accuracy, 'LineWidth', 2);
grid on;
legend('train accuracy', 'test accuracy');
xlabel('epoch');
ylabel('Accuracy');
 
% Visual test
% Gray Image
% Get rid of ones
##Xtest = Xtest(:, 2:end);
##
##figure;
##test_index = 201;
##colormap(gray);
##image=reshape(Xtest(test_index,:),20,20);
##
##imagesc(image, [-1 1]);
##ypred(test_index, end)
##