clc
clear all
load 'SF/Graphs.mat';
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
%%
subplot(2,1,1)
hold on; grid on; box on;

colors=lines;
CM=[colors(1,:);colors(30,:);colors(180,:);colors(220,:)];%colors(256,:)];

count2 =0;
for Delay = [1 5 10 15]
    count=0;
    count2 = count2+1;
Mar = ['o','+','*','v'];
for WaitingTime=[1,5,10,15]
    count = count+1;
 
load(strcat('Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
multiplicator = [0.1:0.2:2.1];
plot(multiplicator*sum(OriginalDemand,'all'), objs(:,1)/24000','k','LineWidth',2);
%plot(multiplicator*sum(OriginalDemand,'all'), objs(:,2),'g');
plot(multiplicator*sum(OriginalDemand,'all'), (objs(:,2)+objs(:,3))/24000','Color',CM(count,:),'Marker',Mar(count2),'MarkerSize',8,'LineWidth',1);
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Societal Cost [1000 h]')
%xlabel('Demands per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
    end
end
subplot(2,1,2)
hold on; grid on; box on;
count2 =0;
for Delay = [1 5 10 15]
count=0;
count2 = count2+1;
Mar = ['o','+','*','v'];

for WaitingTime=[1,5,10,15]
    count = count+1;
    
load(strcat('Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
multiplicator = [0.1:0.2:2.1];
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
plot(multiplicator*sum(OriginalDemand,'all'), 100-Improv*100,'Color',CM(count,:),'Marker',Mar(count2),'MarkerSize',8,'LineWidth',1);
xlabel('Demands per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Improvement [\%]')
ylim([0 50])

end
end
%%
figure()
hold on; grid on; box on;
Mar = ['o','+','*','v'];
h(1)=plot(NaN, NaN,'k','LineWidth',2);
h(2)=plot(NaN, NaN,'Color',CM(1,:),'LineWidth',2);
h(3)=plot(NaN, NaN,'Color',CM(2,:),'LineWidth',2);
h(4)=plot(NaN, NaN,'Color',CM(3,:),'LineWidth',2);
h(5)=plot(NaN, NaN,'Color',CM(4,:),'LineWidth',2);
h(6)=plot(NaN, NaN,'Marker',Mar(1),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(7)=plot(NaN, NaN,'Marker',Mar(2),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(8)=plot(NaN, NaN,'Marker',Mar(3),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(9)=plot(NaN, NaN,'Marker',Mar(4),'MarkerSize',8,'Color','k','Linestyle', 'none');

count2=0;
for Delay = [1 5 10 15]
count=0;
count2=count2+1;
for WaitingTime=[1,5,10,15]
count = count+1;
    
load(strcat('Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
multiplicator = [0.1:0.2:2.1];
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
plot(multiplicator*sum(OriginalDemand,'all'), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'MarkerSize',8,'Color',CM(count,:),'LineWidth',1);
%xlabel('Demands per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Pooled Rides [\%]')
ylim([0 100])

    end
end
legend(h,'Base Case','$\bar{t}=1$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%%
for Delay = [1 5 10 15]
count=0;
count2=count2+1;
for WaitingTime=[1,5,10,15]
count = count+1;
    
load(strcat('Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
multiplicator = [0.1:0.2:2.1];
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
plot(multiplicator*sum(OriginalDemand,'all'), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'Color',CM(count,:),'LineWidth',1);
xlabel('Demands per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Pooled Rides [\%]')
ylim([0 100])

    end
end
legend(h,'Base Case','$\bar{t}=1$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
 

%%
fig=figure()
for iii=[1 2 3 4 5 6 7 8 10]
Matt=[];
for Delay = [1 2 3 5 10 15]
    temp = [];
for WaitingTime=[1,2,3,5,10,15]
  
load(strcat('SF\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
multiplicator = [0.1:0.2:2.1];
%set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%plot(multiplicator*sum(OriginalDemand,'all'), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'Color',CM(count,:),'LineWidth',1);
%xlabel('Demands per Hour')
%set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%ylabel('Pooled Rides [\%]')
%ylim([0 100])
num=iii;
temp = [temp 100*(-objs(num,2)-objs(num,3) + objs(num,1))/objs(num,1)];
end
    Matt = [Matt; temp];
end
Delay = [1 2 3 5 10 15];
WaitingTime=[1,2,3,5,10,15];
[XX,YY]=meshgrid(Delay,WaitingTime);
nexttile
Dems = roundn(multiplicator(iii)*TotDems,2);
%minCol= min(Matt,'all');
%maxCol = max(Matt,'all');
contourf(XX,YY,Matt)
caxis([20,50]); 
title(strcat ( num2str(Dems) ,' Demands/h'),'FontSize', 16,'interpreter','latex' )
caxis([20,50]);
%ylabel('Delay','FontSize', 18,'interpreter','latex')
%xlabel('Waiting Time','FontSize', 18,'interpreter','latex')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)%,'interpreter','latex')
box on;
grid on;

end
h = axes(fig,'visible','off'); 
h.Title.Visible = 'on';
h.XLabel.Visible = 'on';
h.YLabel.Visible = 'on'; 
cc=colorbar(h,'ticklabelinterpreter','Latex','fontsize',18)
cc.Label.FontSize=30;
cc.Label.String="Improvement [\%]";
cc.Position= [0.925 0.11 0.025 0.82];
cc.Label.Interpreter = 'Latex';
caxis(h,[20,50]); 
axis equal
ylabel(h,'Delay [min]','FontSize', 32,'interpreter','latex')
xlabel(h,'Waiting Time [min]','FontSize', 32,'interpreter','latex')
set(gca,'FontSize',22)
% ylabel(h,'Delay','FontSize', 18,'interpreter','latex')
% xlabel(h,'Waiting Time','FontSize', 18,'interpreter','latex')
% set(gca,'FontSize',18)
% set(fig, 'Renderer', 'painters')
% 
% saveas(h,'Surface2','epsc')
