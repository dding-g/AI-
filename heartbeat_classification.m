clc;
clear all;

% test_accuracy�� ���� ���� ���� ���� ���� ���̴�.

% Xtrain, Xtest, Ytrain, ytest ��������
load('./dataset_process/dataset/heartbeat_TrainTestData.mat');

% number of classes 
k=3;


% data�� �������� �Լ� �� �غ�
%sel = randperm(size(Xtrain, 1));
%sel = sel(1:100);
%displayData(Xtrain(sel, :)); 

m_train = size(Xtrain,1); % train �� test�� ũ�Ⱑ �ٸ�
m_test = size(Xtest,1);

Xtrain=[ones(m_train,1) Xtrain]; % Bias�� �����ϱ� ���ؼ� 1�� �߰�
Xtest =[ones(m_test,1) Xtest];

n = size(Xtrain,2); 

%compute cost and gradient
iter=500; % Number of epoch

% Initial weights
% �̷��� �ϸ� �Ź� �ʱⰪ�� �ٲ�� ������ �� ���� ��Ÿ�� ���� ���� �ִ�.
theta=0.01*randn(n,k); 
% Learning rate
alpha=1e-5 % alpha �� �۾����� ��Ȯ���� ��������, epoch�� �� ��������Ѵ�. �н� �ӵ��� ������ ����
% Regularization coefficient
lambda=0; 

% to save optimized thetas
th=zeros(n,k,iter); % �̷��� �ϸ� 3���� (1,2) �̷��� �ϸ� 2����
% save values
% �̸� �޸𸮸� ��Ƴ�. �׷��� ������ �ӵ��� �������� ����. 
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
plot(1:iter, train_loss, 1:iter, test_loss, 'LineWidth', 2); %plot 2���� �ѹ��� �����ֱ��
grid on;
legend('train loss', 'test loss');
xlabel('epoch');
ylabel('Loss');

%test_accuracy �� ���̻� �������� �ʴ´ٸ�, ���� �Ѱ��� ���� �ִ�.
%Ȥ�� overffiting�� �Ǿ��ų�. �̶��� regularization�� �Ѽ� Ȯ���Ѵ�.
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