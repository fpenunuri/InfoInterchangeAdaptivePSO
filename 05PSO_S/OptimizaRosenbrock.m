%Optimizing the Rosenbrock funcion 

n = 30; %dimension
L = 30;

bL = -L*ones(1,n);   
bU = L*ones(1,n);

imax = 5000;
arg_kind = 'mat'; 
strat=2;

m=300;
c1=2;
c2=2;
minimo=0;

disp('optimization using the standard PSO')
[bestS,minvS,tmS] = Pso_standard(@RosenbrockFM,bL,bU,...
					 m,imax,c1,c2,arg_kind);   
                 
fprintf('%s%f\n','minimum: ',minvS);     

Aerror = abs(minimo - minvS);
acerr=1e-5;
fprintf('%s%.1e%s%d\n\n','convergence to an acceptable error of ',...
    acerr,': ',Aerror<=acerr);

disp('optimization using the proposed method')
addpath('../01AdaptPSO')

[best,minv,tm] = PsoAdaptInterInfo(@RosenbrockFM,bL,bU,...
					 m,imax,c1,c2,1e-8,5,'true',arg_kind,strat);
         
fprintf('%s%f\n','minimum: ',minv);     

Aerror = abs(minimo - minv);
acerr=1e-5;
fprintf('%s%.1e%s%d\n','convergence to an acceptable error of ',...
    acerr,': ',Aerror<=acerr);
  
% Rosenbrock function
% X matrix or row-vector
function f_result = RosenbrockFM(X)  
  n = size(X,2);
  Xcut1 = X(:,1:n-1);
  Xcut2 = X(:,2:n);
  f_result = sum((1.0 - Xcut1).^2 + 100*(Xcut2 - Xcut1.^2).^2,2);
end  



  

    
    
    
    
    
    
    
    
    
    
    
    
    
