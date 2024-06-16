% rgen = CouplerPoint4R(th,x0,y0,r1,r2,r3,r4,rcx,rcy,th0,circuit) 
% calculates the coordinates (position vector) of the coupler point for a 
% planar 4R mechanism. The 'circuit' argument must be 1 or -1, and it is 
% used to choose the circuit. It is the user's responsibility to select 1 
% or -1, as using any other value will result in the function not 
% displaying any message and the obtained value will not be correct. The 
% other arguments can be scalars or column vectors of mx1. If they are mx1, 
% rgen is obtained for m different mechanisms at a single input angle. 
% Additionally, th can be a row vector of 1xn or an mxn matrix. In the case 
% where th is 1xn and the other variables are scalars, rgen is obtained for 
% the same mechanism but at n different input angles th. If th is an mxn 
% matrix (and the other parameters are mx1), rgen is obtained for m 
% different mechanisms, each evaluated at n different input angles.
% This function returns 'NaN' if the mechanism cannot be physically 
% assembled for the specified parameters. In general, rgen is mx2xn where 
% the first index is for the different mechanisms, the second index is for 
% the x or y coordinates of the coupler point, and the third index refers 
% to the nth point of the trajectory (corresponding to the nth input 
% angle). If you want the first index to correspond to the points instead 
% of the different mechanisms, you can use: rgper = permute(rgen, [3,2,1])

% Universidad Autonoma de Yucatan
% F. Penunuri
function [rgen] = CouplerPoint4R(th,x0,y0,r1,r2,r3,r4,rcx,rcy,psi,circuit)
    
    L3 = (r4.^2 - r1.^2 - r2.^2 - r3.^2)./(2.0*r2.*r3);
    L2 = r1./r3;
    L1 = r1./r2;
    
    cth = cos(th);
    sth = sin(th);

    ka = cth + L3 - L1 + L2.*cth;
    kb = -2.0*sth;
    kc = L1 + L3 + (L2 - 1.0).*cth;
    disc = kb.^2 - 4*ka.*kc;
    disc(disc<0) = NaN;
    
    nc = size(th,2); 
    nr = length(x0);
    
    th3 = 2.0*atan2(-kb + circuit*sqrt(disc),2.0*ka);
    
    cth3 = cos(th3);
    sth3 = sin(th3);

    r2cth   = r2.*cth;
    rcxcth3 = rcx.*cth3;
    rcysth3 = rcy.*sth3;
    r2sth   = r2.*sth;
    rcxsth3 = rcx.*sth3;
    rcycth3 = rcy.*cth3;

    pxn0 = cos(psi).*(r2cth + rcxcth3 - rcysth3) - ...
           sin(psi).*(r2sth + rcxsth3 + rcycth3);

    pyn0 = sin(psi).*(r2cth + rcxcth3 - rcysth3) + ...
           cos(psi).*(r2sth + rcxsth3 + rcycth3);
    
    px = x0 + pxn0;
    py = y0 + pyn0;
    
    rgenaux = cat(1,px,py);
    rgen = reshape(rgenaux,[nr,2,nc]);
end


