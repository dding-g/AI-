function [ypred, test_accuracy, test_loss] = MLR_test(xtest, ytest, theta)

[m, n] = size(xtest);
[n, k] = size(theta);

linear_h=xtest*theta; %target prediction

% probability calculation
hp=zeros(m,k);
ypred=zeros(m,1);
test_loss=0;
for i=1:m
  hp(i,:)=softmax(linear_h(i,:)); % Hypothesis Function
  test_loss = test_loss - log(hp(i,ytest(i)));
  [junk maxind] = max(hp(i,:));
  ypred(i)=maxind;
end

norm_th = norm(theta(:)).^2;
test_loss = test_loss/m;

test_accuracy = mean(ytest==ypred)
 
endfunction
