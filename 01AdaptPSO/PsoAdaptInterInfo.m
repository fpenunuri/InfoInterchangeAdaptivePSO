% PSO with adaptive search space and interchange of information
% [mejor, minimo, tiempo] = PsoAdaptInterInfo(fob,bL,bU,m,itmax,c1,c2,...
%                                       tol,nadapt,info,arg_kind,strat)
% input variables:
% mejor: best particle position
% minimo: minimum vale for the objective function
% tiempo: elapsed time.
%
% output variables:
% fob: the objective function to minimize
% bL, bU: limits for the search space
% m: number of particles
% itmax: number of iterations
% c1, c2: the cognition and social acceleration coefficients
% nadapt: number of times the search space is readjusted
% tol: "absolute error" the algorithm stops if:
% (norm(gb_expk1-gb_expk2) < tol where gb_expk1 is the best position
% at adaptation k1, gb_expk2 is the best position at adaptation k1+1
% info: logical variable, if info = true, some information about the
% optimization process is showed.
% arg_kind: can be 'mat' or 'vec'
% if the objective function accepts a matrix mxn as argument, that is to 
% say, f([x11,x12,...x1n; x21,x22,...x2n;...; xm1, xm2, ..., xmn]) gives a 
% column vector with values [f1;f2;...;fm], the objective function 
% evaluated on each row [xk1,xk2,...xkn], use  arg_kind = 'mat';
% If the objective function only acts on vectors, use  arg_kind = 'vec'
% If the objective function is not programmed from its 'inception' to 
% accept a matrix as an argument, the efficiency of the code is reduced. If
% the objective function is defined to accept scalars, that is, it is in 
% the form fs = fob_scalar(x1, x2, x3, ... xn), we first convert fob_scalar 
% to the form fob_vec (the one that accepts a vector as an argument) as 
% follows:
% 
%   function [fv] = fob_vec(x_vector)
%        n2cx = num2cell(x_vector,1);
%        [x1,x2,...,xn] = n2cx{:};
%        fv = fob_escalar(x1,x2,x3,...,xn);
%    end
%
% Now it can be used arg_kind = 'vec'
%
% strat: can be 1 or 2, depending on the space adaptation strategy.
% strat=1 is in general a good choice. See the paper for more details.

% Autor: F. Penunuri
function [best,minv,tm] = PsoAdaptInterInfo(fob,bL,bU,m,itmax,c1,c2,tol,...
                                            nadapt,info,arg_kind,strat)
  
  tStart = tic;
  thmin = 0; thmax = 1;
  n = size(bL,2);   
  mejoresMat = zeros(nadapt,n); minvec=zeros(1,nadapt);
  xm = (bL+bU)/2;
  bLk = bL; bUk = bU;
  gbk = X0(1,bL, bU);    
  
  cont = 0;    
  %adapting search space
  fprintf('%s  %s\n','Adapt(#)', 'best value');
  for k1=1:nadapt
    X = X0(m,bLk,bUk);
    X(1,:) = bLk;
    X(m,:) = bUk;
    Pb = X;        
    V = zeros(m,n); 
    %PSO optimization with information interchange
    [gb,minv]=PsoInterInfo(fob,bL,bU,X,Pb,V,itmax,0.5,thmax,...
                           thmin,c1,c2,arg_kind);
    
    minvec(k1) = minv;
    mejoresMat(k1,:) = gb;       
    %information about the optimization process
    if(info)
      fprintf('%d\t  %.5f\n',k1, minv);
    end       
    if(norm(gbk-gb)<tol) 
      break;
    end       

    gbk = gb;
    
    if(strat == 1)
      bLk = gb - abs(xm-gb);
      bUk = gb + abs(gb-xm);
      
      bLk = (bLk<bL).*bL + (bLk>=bL).*bLk;
      bUk = (bUk>bU).*bU + (bUk<=bU).*bUk;
      xm  = (bLk+bUk)/2;
    elseif(strat == 2)
      bLk = xm - abs(xm-gbk); 
      bUk = xm + abs(gbk-xm);   

      bLk = (bLk<bL).*bL + (bLk>=bL).*bLk;
      bUk = (bUk>bU).*bU + (bUk<=bU).*bUk;
    else
      (error('strat must be 1 or 2'));
    end
    
    cont = cont+1;
  end            
  minvecAlo = minvec(1:cont);
  [minv, minloc] = min(minvecAlo);
  best = mejoresMat(minloc,:);
  tm = toc(tStart);    
end












