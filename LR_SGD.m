function [th, train_loss, train_accuracy] = LR_SGD(theta, xtrain, ytrain,alpha,iter, tol)
%Cost Summary of this function goes here
%   Detailed explanation goes here
  th=theta;
  m=size(xtrain,1);
  
  dummy=th;
  
  for j=1:iter
    j
    train_loss=0;
    
    for i=1:m
      h=1./(1+exp(-xtrain(i,:)*th));
      th=th - (alpha/m)*(h-ytrain(i))*xtrain(i,:)';
      train_loss(i,j) = -ytrain(i)*log(h) - (1 - ytrain(i))*log(h);
    end
    
    linear_h=xtrain*th; %target prediction

    ypred=zeros(m,1);

    for i=1:m
      hp(i,:)=softmax(linear_h(i,:)); % Hypothesis Function
      train_loss = train_loss - log(hp(i,ytrain(i)));
      [junk maxind] = max(hp(i,:));
      ypred(i)=maxind;
    end

    train_loss = train_loss/m;
    train_accuracy = mean(ytrain==ypred);
    
    if norm(th-dummy)<tol
      break;
    end
    dummy=th;
  end
end

