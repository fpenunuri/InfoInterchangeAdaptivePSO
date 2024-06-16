%rotated (and shifted) Rosenbrock function.
%X matrix
function f_result = auxRosenbrockRotFM(X,os,RM)             
      Xsf = 2.048/100.0*(X - os);
      %Z = RM*Xsf' + 1.0;
      Z = Xsf*RM' + 1.0;
      f_result = RosenbrockFM(Z) - 900.0;
end 

