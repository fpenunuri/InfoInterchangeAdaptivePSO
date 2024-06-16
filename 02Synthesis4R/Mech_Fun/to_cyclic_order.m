% functions that orders---cyclic order in [0 2*pi)--- the rows of A
%
function [Acs] = to_cyclic_order(A)
dA0 = 2*pi - A(:,1);
A0 = bsxfun(@plus,A,dA0);
Acirc = mod(A0,2*pi);
[~, iA] = sort(Acirc,2);

[m,~] = size(A);
rc = (1:m).';

 % since the elements of iA are indices for rows, we need to transform iA
 % to linear indices
 lindex = bsxfun(@plus,(iA-1)*m,rc);
 Acs = A(lindex);
end
