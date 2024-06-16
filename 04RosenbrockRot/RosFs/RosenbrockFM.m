% Rosenbrock function
%X matrix
function f_result = RosenbrockFM(X)  
  n = size(X,2);
  Xcut1 = X(:,1:n-1);
  Xcut2 = X(:,2:n);
  f_result = sum((1.0 - Xcut1).^2 + 100*(Xcut2 - Xcut1.^2).^2,2);
end  
