function [prob]  = probcombN(a,waiting)
waiting=waiting/(60); %min in hours
n = length(a);
prob = 0;
if sum(a==0) >= 1
else
    for ii = 1: n
        a_temp = a;
        a_temp(ii) = [];
        prob =  prob + (a(ii) / sum(a) ) * prod(1 - exp(-a_temp*waiting) );
    end
end
end

