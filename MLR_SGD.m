function th = LR_SGD(theta, xtrain, ytrain,alpha,iter, tol)
%Cost Summary of this function goes here
%   Detailed explanation goes here
  th=theta;
  m=size(xtrain,1);

  dummy=th;
  
  for j=1:iter
    j
    
    for i=1:m
      h=1./(1+exp(-xtrain(i,:)*th));
      th=th - (alpha/m)*(h-ytrain(i))*xtrain(i,:)';
    end
    
    if norm(th-dummy)<tol
      break;
    end
    dummy=th;
  end
end

