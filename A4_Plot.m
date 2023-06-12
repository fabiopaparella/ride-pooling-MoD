clc
clear all
load 'SF\Graphs.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
DemandS= DemandS/24;
OriginalDemand= DemandS;
TotDems = sum(DemandS,'all');

set(gca,'ticklabelinterpreter','Latex','fontsize',16)
set(groot,'defaulttextinterpreter','latex')
set(groot,'defaultaxesticklabelinterpreter','latex')
set(groot,'defaultlegendinterpreter','latex')
multiplicator = [0.05 0.1 0.2 0.4 0.8 1.6];
vec = [1 2 5 10 15]; 
Mar = ['o','+','*','v','x'];
%%
% subplot(2,1,1)
% hold on; grid on; box on;
% 
% colors=lines;
% CM=[colors(1,:);colors(30,:);colors(180,:);colors(220,:)];%colors(256,:)];
% 
% count2 =0;
% for Delay = [5 10 15]
%     count=0;
%     count2 = count2+1;
% Mar = ['o','+','*','v'];
% for WaitingTime=[5,10,15]
%     count = count+1;
% load(strcat('Results/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
% multiplicator = [0.25 0.5 1 1.5 2];
% plot(multiplicator*sum(OriginalDemand,'all'), objs(:,1)/240000','k','LineWidth',2);
% plot(multiplicator*sum(OriginalDemand,'all'), (objs(:,2)+objs(:,3))/240000','Color',CM(count,:),'Marker',Mar(count2),'MarkerSize',8,'LineWidth',1);
% set(gca,'ticklabelinterpreter','Latex','fontsize',16,'XTickLabel',[]);
% ylabel('Objective $\times 10^{-4}$ ')
% set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%     end
% end
%%
colors=lines;
CM=[colors(1,:);colors(30,:);colors(180,:);colors(220,:);colors(256,:)];
subplot(2,1,2)
hold on; grid on; box on;
count2 =0;
for Delay = vec
count=0;
count2 = count2+1;


for WaitingTime= vec
    count = count+1;
    
load(strcat('Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
plot(multiplicator*sum(OriginalDemand,'all'), 100-Improv*100,'Color',CM(count,:),'Marker',Mar(count2),'MarkerSize',8,'LineWidth',1);
xlabel('Requests per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Improvement [\%]')
ylim([0 50])

end
end
%%
subplot(2,1,1)
%figure()
hold on; grid on; box on;
%h(1)=plot(NaN, NaN);
h(1)=plot(NaN, NaN,'Color',CM(1,:),'LineWidth',2);
h(2)=plot(NaN, NaN,'Color',CM(2,:),'LineWidth',2);
h(3)=plot(NaN, NaN,'Color',CM(3,:),'LineWidth',2);
h(4)=plot(NaN, NaN,'Color',CM(4,:),'LineWidth',2);
h(5)=plot(NaN, NaN,'Color',CM(5,:),'LineWidth',2);
h(6)=plot(NaN, NaN,'Marker',Mar(1),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(7)=plot(NaN, NaN,'Marker',Mar(2),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(8)=plot(NaN, NaN,'Marker',Mar(3),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(9)=plot(NaN, NaN,'Marker',Mar(4),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(10)=plot(NaN, NaN,'Marker',Mar(5),'MarkerSize',8,'Color','k','Linestyle', 'none');

count2=0;
for Delay = vec
count=0;
count2=count2+1;
for WaitingTime= vec
count = count+1;
    
load(strcat('Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
set(gca,'ticklabelinterpreter','Latex','fontsize',16,'XTickLabel',[]);
plot(multiplicator*sum(OriginalDemand,'all'), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'MarkerSize',8,'Color',CM(count,:),'LineWidth',1);
%xlabel('Demands per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Pooled Rides [\%]')
ylim([0 100])

    end
end
legend(h,'$\bar{t}=1$ min','$\bar{t}=2$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=2$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)

%%
% figure()
% hold on; grid on; box on;
% count2 = 0;
% for Delay = vec
%     count=0;
%     count2=count2+1;
%     for WaitingTime = vec
%         count = count+1;
%         
%         load(strcat('Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
%         set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%         plot(multiplicator*sum(OriginalDemand,'all'), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'Color',CM(count,:),'LineWidth',1);
%         xlabel('Requests per Hour')
%         set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%         ylabel('Pooled Rides [\%]')
%         %ylim([0 100])
%         
%     end
% end
% %legend(h,'No Pooling','$\bar{t}=1$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
% %legend(h,'No Pooling','$\bar{t}=1$ min','$\bar{t}=2$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=2$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
% set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%  

%%
fig=figure()
for iii=[1 2 3 4 5 6]
Matt=[];
for Delay = vec
    temp = [];
for WaitingTime= vec
  
load(strcat('Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
num=iii;
temp = [temp 100*(-objs(num,2)-objs(num,3) + objs(num,1))/objs(num,1)];
end
Matt = [Matt; temp];
end
Delay = vec;
WaitingTime= vec;
[XX,YY]=meshgrid(Delay,WaitingTime);
nexttile
Dems = roundn(multiplicator(iii)*TotDems,2);

contourf(XX,YY,Matt)
caxis([20,50]); 
title(strcat ( num2str(Dems) ,' Demands/h'),'FontSize', 22,'interpreter','latex' )
caxis([20,50]);
set(gca,'ticklabelinterpreter','Latex','fontsize',22)%,'interpreter','latex')
box on;
grid on;

end
h = axes(fig,'visible','off'); 
h.Title.Visible = 'on';
h.XLabel.Visible = 'on';
h.YLabel.Visible = 'on'; 
cc=colorbar(h,'ticklabelinterpreter','Latex','fontsize',18)
cc.Label.String="Improvement [\%]";
cc.Position= [0.925 0.11 0.025 0.82];
cc.Label.Interpreter = 'Latex';
caxis(h,[20,50]); 
%axis equal
ylabel(h,'Delay [min]','FontSize', 32,'interpreter','latex')
xlabel(h,'Waiting Time [min]','FontSize', 32,'interpreter','latex')
set(gca,'FontSize',28)
cc.Label.FontSize=30;
