%Optimizing the Michalewicz funcion using the standard PSO algorithm

n = 10; %dimension
L = pi;

bL = zeros(1,n);   
bU = L*ones(1,n);

imax = 5000;
arg_kind = 'mat'; 
strat=2;

m=300;
c1=2;
c2=2;
minimo=-9.660151716;

[best,minv,tm] = Pso_standard(@MichalewiczFM,bL,bU,...
					 m,imax,c1,c2,arg_kind);   
                 
fprintf('%s%f\n','minimum: ',minv);     

Rerror = abs(1 - minv/minimo);
acerr=1e-5;
fprintf('%s%.1e%s%d\n','convergence to an acceptable error of ',...
    acerr,': ',Rerror<=acerr);


%Michalewicz function
%X can be a matrix
function fr = MichalewiczFM(X)
  ivec = 1:size(X,2);
  fr = -sum(sin(X).*(sin(ivec/pi .* X.^2)).^20,2);
end


  

    
    
    
    
    
    
    
    
    
    
    
    
    
