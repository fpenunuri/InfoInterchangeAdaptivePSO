%4R mechanism for gait rehabilitation
addpath('../02Synthesis4R/Mech_Fun','../02Synthesis4R/ObjectiveF')

%objective function
fob = @fob4R;
L = 1; %maximum length for the links

%search space 
% x = [th_i, x0, y0, r1 ,r2, r3, r4, rcx, rcy, psi]
np = 14;
dim = np + 9;
bL = zeros(1,dim);
bU = zeros(1,dim);
bL(1:np) = 0;
bU(1:np) = 2*pi;
bU(np+1:dim) = [L,L,L,L,L,L,L,L,pi];
%there is no need to search in the range [0,2pi] for th and psi. See 
%figure: "Planar 4R mechanism and its design variables")

%parameters for the method
m = 500;
itmax = 3000;
c1=2; c2=2;
arg_kind = 'Mat'; %The objective function is 'vectorized'; it accepts a 
                  %matrix as an argument
             
[best,minv,tm] = Pso_standard(fob,bL,bU,...
					 m,itmax,c1,c2,arg_kind);   
                 
           
best(1:np) = to_cyclic_order(best(1:np));  

thv = best(1:np);
rest_pars = best((np+1):dim); 
n2c_rest_pars = num2cell(rest_pars,1);
[x0, y0, r1 ,r2, r3, r4, rcx, rcy, psi] = n2c_rest_pars{:};

pts= CouplerPoint4R(thv,x0,y0,r1,r2,r3,r4,rcx,rcy,psi,-1);
 
%results
disp('minimo');
disp(minv);

disp('input angles');
disp(best(1:np));

disp('synthesized mechanism')
disp(best(np+1:end));

%generated points
disp('generated points')
disp(squeeze(pts)');

%saving the data
s = struct('mejor',best,'minimo',minv,'tiempo',tm);
save('optimizacion.mat','-struct','s');


