%operator to randomly generate particle positions
function fr = X0(m,bL, bU)
  fr = bL + rand(m,size(bL,2)).*(bU-bL);
end
