function [prob]  = probcomb(a1,a2,waiting)
waiting=waiting/(60); %min in hours
prob= (1-exp((-a1*waiting))) - a1/(a1+a2)*(exp((-a2*waiting)) - exp((-a1*waiting)));
if a1==0 || a2 == 0
    prob = 0 ;
end
end

