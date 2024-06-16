% Test if the mx4 matrix A satisfies the crank condition. It is assumed 
% that the minimum should be in column 2 and that rk is not equal to 
% r2 (the crank or input link)

function [CC] = isCrankCond(A)
    m = size(A,1);
    c2 = 2*ones(m,1);
    [~,Ia] = min(A,[],2);
    CC = Ia==c2;
end
