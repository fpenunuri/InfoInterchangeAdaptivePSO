%R = RRmat(n), generates a random rotation matrix of size n*n
%
function fr = RRmat(n)
RM = rand(n);
det1=det(RM);
while (det1==0)
    RM = rand(n);
    det1=det(RM);
end

 RRM = orth(RM);
 %RRM=gramschmidt(RM);
 det2 = det(RRM);
 
 if (det2==1)
     fr = RRM;
 else
    fr = RRM([2,1,3:n],:);
 end    
end
