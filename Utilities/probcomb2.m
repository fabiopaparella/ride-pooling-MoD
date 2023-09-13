function [prob]  = probcomb2(a1,a2,waiting)
waiting=waiting/(60); %min in hours
if a1==0 
    prob=0;
elseif a2==0
    prob=0;
else
prob1 = a1/(a1+a2)*(1 - exp(-a2*waiting) ) ;
prob2 = a2/(a1+a2)*(1 - exp(-a1*waiting) ) ;
prob = prob1 + prob2;

end
end

