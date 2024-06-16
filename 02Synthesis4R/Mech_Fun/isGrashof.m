% The function isGrashof([x1, x2, x3, x4]) tests if the numbers x1, x2,
% x3, and x4 satisfy the Grashof condition. The function accepts an mxn
% matrix as an argument. Even though the function works for n ~= 4, the
% Grashof condition makes sense for n=4

% F. Penunuri
function [GC] = isGrashof(x)
    minimos = min(x,[],2);
    maximos = max(x,[],2);
    GC = 2*(minimos + maximos) <= sum(x,2);
end

