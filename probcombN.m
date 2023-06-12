function [prob]  = probcombN(a,waiting)
waiting=waiting/(60); %min in hours
n = length(a);
prob = 0;
if any(a==0)
    disp('prob0')
end
for ii = 1: n
    a_temp = a;
    a_temp(ii) = [];
    prob =  prob + (a(ii) / sum(a) ) * prod(1 - exp(-a_temp*waiting) );
end
end

