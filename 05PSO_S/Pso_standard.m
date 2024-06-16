%Standard version of the PSO algorithm

function [gb1,min1,t1]=Pso_standard(fob,bL,bU,m,gmax,c1,c2,arg_kind)  

    tStart = tic;  
    wmax = 1; wmin = 0;
    X = X0(m, bL, bU);
    Pb = X;
    V = zeros(size(X));
    %PSO optimization
    for k = 1:gmax
        Pb = Pbest(fob,X,Pb,arg_kind);
        [gb1, min1] = Gbest(fob, Pb, arg_kind);                                 
        w = wmax-(wmax-wmin)*(k-1)/(gmax-1);
        V = Vel(X,V,Pb,gb1,c1,c2,w,bL,bU);     
        X = Xpos(X,V,bL,bU);      
    end
    t1 = toc(tStart);
end

%Position operator
function fr = Xpos(Xmenos, V, bL, bU)
    fr = Xmenos + V;
    X0m = X0(size(Xmenos,1),bL,bU);
    from_X0m = or(fr<bL,fr>bU);
    fr = from_X0m.*X0m + ~from_X0m.*fr;    
end

%velocity operator
function fr = Vel(Xmenos,Vmenos,Pb,gbest,c1,c2,w,bL,bU)
    m = size(Xmenos,1);
    r1 = rand(m,1);
    r2 = rand(m,1);
    fr = w*Vmenos + c1*r1.*(Pb-Xmenos) + c2*r2.*(gbest-Xmenos);
    X = Xmenos + fr;
    X0m = X0(m,bL,bU);
    from_X0m = or(X<bL,X>bU);
    fr = from_X0m.*X0m + ~(from_X0m).*fr;
end

%Pbest operator
function S = Pbest(fob,X,P,arg_kind)
    if (strcmpi(arg_kind,'mat'))
        fX = fob(X);
        fP = fob(P);
        fromX = fX<fP;
        fromP = fX>=fP;
        S = fromX.*X + fromP.*P;
    elseif(strcmpi(arg_kind,'vec'))
        cellX = num2cell(X,2);
        cellP = num2cell(P,2);
        fX = cellfun(fob,cellX);
        fP = cellfun(fob,cellP);
        fromX = fX<fP;
        fromP = fX>=fP;
        S = fromX.*X + fromP.*P;
    else
        error(['error arg_kind must be ''mat'' or ''vec'' in' ...
               'DE_Method:sel_opM']) 
    end        
end

%Gbest operator
function [mejor, minimo] = Gbest(fob, P, arg_kind)
    if (strcmpi(arg_kind,'mat'))
        fvals = fob(P);
        [minimo, minloc] = min(fvals);
        mejor = P(minloc,:);
    elseif(strcmpi(arg_kind,'vec'))
        cellP = num2cell(P,2);
        fvals = cellfun(fob,cellP);
        [minimo, minloc] = min(fvals);
        mejor = P(minloc,:);
    else
        error(['error arg_kind must be ''mat'' or ''vec'' in' ...
               'DE_Method:best_opM']) 
    end   
end

%operator to randomly generate particle positions
function fr = X0(m,bL, bU)
    fr = bL + rand(m,size(bL,2)).*(bU-bL);
end
