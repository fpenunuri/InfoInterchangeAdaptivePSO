% this function test if a set of angles in [0,2*pi) or (0,2*pi]--a
% single revolution-- stored in the rows of A, are in cyclic order. For
% instance is2pi_order([350,355,360]*pi/180) = 1
% is2pi_order([350,355,360,1,2]*pi/180) = 1
% is2pi_order([0,355,1,2]*pi/180) = 0 (more than 1 revolution)
% the order is tested counterclockwise  (use -A for the clockwise case)

function [fr] = is2pi_order(A)
    dA0 = 2*pi - A(:,1);
    A0 = bsxfun(@plus,A,dA0); %recent versions of Matlab accepts A + dA0
    Acirc = mod(A0,2*pi);
    fr = isordered(Acirc);
end

