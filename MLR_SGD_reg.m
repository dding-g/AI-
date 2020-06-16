function [th, train_accuracy, train_loss] = MLR_SGD_reg(theta, Xtrain, Ytrain,alpha,lambda)
%Cost Summary of this function goes here
%   Detailed explanation goes here
th=theta;
m=size(Xtrain,1);

  
for i=1:m
  z = Xtrain(i,:)*th;
  py_x = softmax(z);
  th(:,1)=th(:,1) - (alpha)*((py_x(1)-(Ytrain(i)==1))*Xtrain(i,:)'+lambda*th(:,1)); %MLR_SGD에서 lambda값만 더해줌
  th(:,2)=th(:,2) - (alpha)*((py_x(2)-(Ytrain(i)==2))*Xtrain(i,:)'+lambda*th(:,2));
  th(:,3)=th(:,3) - (alpha)*((py_x(3)-(Ytrain(i)==3))*Xtrain(i,:)'+lambda*th(:,3));
end

linear_h=Xtrain*th; %target prediction

ypred=zeros(m,1);
train_loss=0;

for i=1:m
  hp(i,:)=softmax(linear_h(i,:)); % Hypothesis Function
  train_loss = train_loss - log(hp(i,Ytrain(i)));
  [junk maxind] = max(hp(i,:));
  ypred(i)=maxind;
end

train_loss = train_loss/m;
train_accuracy = mean(Ytrain==ypred);

end

