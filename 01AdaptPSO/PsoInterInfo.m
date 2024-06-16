
% An auxiliary function for the proposed method, PsoAdaptInterInfo: This
% function implements the interchange of information within PSO
									 
function [gb1,min1]=PsoInterInfo(fob,bL,bU,X,Pb,V,gmax,Cr,...
				    thmax,thmin,c1,c2,arg_kind)  

%PSO optimization
  for k = 1:gmax             
    [gb1, min1] = Gbest(fob, Pb, arg_kind);
    Pb = Pbest(fob,X,Pb,arg_kind);                           
    thk = thmax-(thmax-thmin)*(k-1)/(gmax-1);
    V = Vel(X,V,Pb,gb1,c1,c2,thk,bL,bU);     
    X = Xpos(X,V,bL,bU);
    XPb = InfoCross(X,Pb,Cr);
    X = Pbest(fob,X,XPb,arg_kind);
  end
end

%Interchange of information, with, essentially, the DE crossover operator
function U = InfoCross(X, Pb, Cr)
  [m,n] = size(X);   
  rand_mat = rand(m,n);  
  fromPb = rand_mat<=Cr;
  U = fromPb.*Pb + ~fromPb.*X;  
end

%Position operator
function fr = Xpos(Xmenos, V, bL, bU)
  fr = Xmenos + V;
  X0m = X0(size(Xmenos,1),bL,bU);
  from_X0m = or(fr<bL,fr>bU);
  fr = from_X0m.*X0m + ~from_X0m.*fr;    
end

%velocity operator
function fr = Vel(Xmenos, Vmenos, Pb, gb, c1, c2, thk, bL, bU)
  m = size(Xmenos,1);

  r1 = rand(m,1);
  r2 = rand(m,1);
  fr = thk*Vmenos + c1*r1.*(Pb-Xmenos) + c2*r2.*(gb-Xmenos);

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
             'PsoInterInfo:Pbest']) 
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
             'PsoInterInfo:Gbest']) 
  end   
end	
