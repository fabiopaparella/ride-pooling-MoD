function [prob]  = probcomb3(a1,a2,a3,waiting)
waiting=waiting/(60); %min in hours
if a1==0 
    prob=0;
elseif a2==0
    prob=0;
elseif a3==0
    prob=0;
else
prob1 = a1/(a1+a2+a3)*(1 - exp(-a2*waiting) )*(1 - exp(-a3*waiting) ) ;
prob2 = a2/(a1+a2+a3)*(1 - exp(-a1*waiting) )*(1 - exp(-a3*waiting) ) ;
prob3 = a3/(a1+a2+a3)*(1 - exp(-a1*waiting) )*(1 - exp(-a2*waiting) ) ;
prob = prob1 + prob2 + prob3;
end
end

