function [prob]  = probcomb4(a1,a2,a3,a4,waiting)
waiting=waiting/(60); %min in hours
if a1==0 
    prob=0;
elseif a2==0
    prob=0;
elseif a3==0
    prob=0;
else
prob1 = a1/(a1+a2+a3+a4)*(1 - exp(-a2*waiting) )*(1 - exp(-a3*waiting) )* (1 - exp(-a4*waiting) ) ;
prob2 = a2/(a1+a2+a3+a4)*(1 - exp(-a1*waiting) )*(1 - exp(-a3*waiting) )* (1 - exp(-a4*waiting) ) ;
prob3 = a3/(a1+a2+a3+a4)*(1 - exp(-a1*waiting) )*(1 - exp(-a2*waiting) )* (1 - exp(-a4*waiting) ) ;
prob4 = a4/(a1+a2+a3+a4)*(1 - exp(-a1*waiting) )*(1 - exp(-a2*waiting) )* (1 - exp(-a3*waiting) ) ;


prob = prob1 + prob2 + prob3 + prob4;
end
end

