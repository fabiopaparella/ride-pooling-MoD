DemandS = zeros(357);
for iii=1:53000
    x = outdata(iii,2);
    y = outdata(iii,3);
    if x && y > 0
    DemandS(x,y) = DemandS(x,y) +1;
    end
end
save('Demm.mat', 'DemandS')