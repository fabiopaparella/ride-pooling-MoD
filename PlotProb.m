clear all
count= 0;

% figure()
% hold on; grid on; box on;
Prob = [];
for ii = 10:10:200
    count = count +1;
    count2 = 0;
    for jj = 10:10:200
        count2 = count2 +1;
        for wt = 2%0:15
            Prob2(count,count2) = probcombN([ii,jj],wt);
            %Prob3(count,count2) = probcombN([ii,ii,ii],wt);
            Prob4(count,count2) = probcombN([ii,ii,jj,jj],wt);
            %Prob5(count,count2) = probcombN([ii,ii,ii,ii,ii],wt);
            Prob6(count,count2) = probcombN([ii,ii,ii,jj,jj,jj],wt);
            Prob8(count,count2) = probcombN([ii,ii,ii,ii,jj,jj,jj,jj],wt);
            Prob10(count,count2) = probcombN([ii,ii,ii,ii,ii,jj,jj,jj,jj,jj],wt);
            Prob12(count,count2) = probcombN([ones(1,6)*ii,ones(1,6)*jj],wt);
            Prob16(count,count2) = probcombN([ones(1,8)*ii,ones(1,8)*jj],wt);
            Prob20(count,count2) = probcombN([ones(1,10)*ii,ones(1,10)*jj],wt);
        end
    end
end
[XX,YY]= meshgrid([10:10:200],[10:10:200]);
subplot(2,3,1)
contourf(XX,YY,Prob2)%,'Marker','o','MarkerSize',8,'Color','k','LineWidth',1)%,'Marker','o-')
subplot(2,3,2)
contourf(XX,YY,Prob4)
subplot(2,3,3)
contourf(XX,YY,Prob8)
subplot(2,3,4)
contourf(XX,YY,Prob12)
subplot(2,3,5)
contourf(XX,YY,Prob16)
subplot(2,3,5)
contourf(XX,YY,Prob20)

% plot(ii, Prob3,'Marker','x','MarkerSize',8,'Color','r','LineWidth',1)%,'Marker','x-')
% plot(ii, Prob4,'Marker','+','MarkerSize',8,'Color','b','LineWidth',1)%,'Marker','+-')