% A function that determines if the rows are in ascending order

function [fr] = isordered(A)
%   As = sort(A,2);
%   fr = logical(prod(~(As - A),2));
  fr = logical(prod(sort(A,2)==A,2));
end
