%Optimizing the Michalewicz funcion. 

addpath('../01AdaptPSO')
addpath('./MichFs')

n = 10; %dimension
L = pi;

bL = zeros(1,n);   
bU = L*ones(1,n);

imax = 2000; %numero de iteraciones
nexper = 5;
tol = 1e-9;
info = false;
                
arg_kind = 'mat'; 
strat=2;
        
mv = 100;
cv = 2;
kmax=1;

%The studies in the paper are for:
%mv=floor(linspace(20,100,5));
%cv=[1.8,1.9,2];
%kmax = 1000 
%This would result in 45,000 optimizations! On the computer where the 
%experiments were conducted, each optimization takes about 1 second.

mat_3tuples=cartp(mv,cv,cv);
c1v=mat_3tuples(:,2);
c2v=mat_3tuples(:,3); 

for ii=1:size(mat_3tuples,1)
    m=mat_3tuples(ii,1); 
    c1= c1v(ii);
    c2= c2v(ii);
    str1='./Data/minimos_t_';
    fileID1 = fopen(sprintf('%sm%d_%d_%d.dat',str1,m,c1*10,c2*10),'a'); 
    
    for k=1:kmax
      fprintf('%d%s%d\n',k,'/',kmax)

      [best,minv,tm] = PsoAdaptInterInfo(@MichalewiczFM,bL,bU,...
					 m,imax,c1,c2,tol,nexper,info,arg_kind,strat);

      fprintf('%s %0.9f\n', 'minimum',minv);
      fprintf('\n');
      fmt = '%.9f %.9f \n';
      fprintf(fileID1,fmt, [minv,tm]);
    end
    fclose(fileID1);
end                


    
    
    
    
    
    
    
    
    
    
    
    
    