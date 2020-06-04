function sm=softmax(z)
  
  sm=exp(z)./sum(exp(z));
  
endfunction
