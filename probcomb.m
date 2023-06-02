function [prob]  = probcomb(a1,a2,waiting)
waiting=waiting/(60); %min in hours
if a1==0 
    prob=0;
elseif a2==0
    prob=0;
else
prob= 1- ( a1*exp(-a2*waiting)+ a2*exp(-a1*waiting) )/(a1+a2);
end
end

