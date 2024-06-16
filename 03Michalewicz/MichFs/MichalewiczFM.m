%Michalewicz function
%X can be a matrix
function fr = MichalewiczFM(X)
  ivec = 1:size(X,2);
  fr = -sum(sin(X).*(sin(ivec/pi .* X.^2)).^20,2);
end 
  