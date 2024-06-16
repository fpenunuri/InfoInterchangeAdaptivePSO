%Optimizing the rotated Rosenbrock funcion. 

addpath('../01AdaptPSO')
addpath('./RosFs')

n = 30;  %dimension
L = 30;

bL = -L*ones(1,n);   
bU = L*ones(1,n);

RM = RRmat(n);
os = bL + (bU-bL).*rand(1,n);

%objective function
RosenbrockRotFM = @(Z) auxRosenbrockRotFM(Z,os,RM);

imax = 2000; 
nexper = 5;
tol = 1e-9;
info = false;
                
arg_kind = 'mat'; 
strat=2;
        
mv = 300;
cv=2;
kmax=1;
%The studies in the paper are for:
%mv=floor(linspace(150,300,5));
%cv=[1.8,1.9,2];
%kmax = 1000 
%This would result in 45,000 optimizations! On the computer where the 
%experiments were conducted, each optimization takes about 8 second for
%m = 300.

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

      [best,minv,tm] = PsoAdaptInterInfo(RosenbrockRotFM,bL,bU,...
					 m,imax,c1,c2,tol,nexper,info,arg_kind,strat);

      fprintf('%s %0.9f\n', 'minimum',minv);
      fprintf('\n');

      %dlmwrite('./Data/minimos_t.dat',[minv,tm],'delimiter', '\t',...
      %    'precision', 9,'-append');

      fmt = '%.9f %.9f \n';
      fprintf(fileID1,fmt, [minv,tm]);

                %dlmwrite(sprintf('./Data/mejores_m%d.dat',m),best,...
                %    'delimiter', ' ','precision', 9,'-append');
    end
    fclose(fileID1);
end
        
        


    
    
    
    
    
    
    
    
    
    
    
    
    