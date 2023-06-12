clc
clear all
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
set(groot,'defaulttextinterpreter','latex')
set(groot,'defaultaxesticklabelinterpreter','latex')
set(groot,'defaultlegendinterpreter','latex')
vec = [1 2 5 10]; 
Mar = ['o','+','*','v','x'];
city='NYC20';
%% group together

for Delay =vec%[2 5]% 
    
    for WaitingTime= vec %[1 2 5 10 15]%vec
        Improv = [];
        objs = [];
        TrackDems = [];
        TotG = [];
        Del = [];
        for multiplicator = [0.4 0.8] %   0.01 1.6 0.005 0.01 0.03 0.05 0.1 0.2
            load(strcat(city,'/Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'Dem',num2str(multiplicator),'.mat'),'TrackDems_temp','objs_temp','Improv_temp','Cumul_delay','TotGamma')
            Improv = [Improv Improv_temp];
            objs = [objs; objs_temp];
            TrackDems = [TrackDems; TrackDems_temp];
            TotG = [TotG TotGamma];
            Del = [Del Cumul_delay];
        end
        save(strcat(city,'/Results\New_Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv','TotG','Del')
    end
end


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
%%
subplot(2,1,2)
hold on; grid on; box on;

multiplicator = [0.005 0.01 0.03 0.05 0.1 0.2 0.4 0.8 1.6];%1.6
count2 =0;
for Delay = vec(1:end-1)
count=0;
count2 = count2+1;


for WaitingTime= vec(1:end-1)
    count = count+1;
    
load(strcat('NYC/Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
plot(TrackDems(:,1), 100-Improv*100,'Color',CM(count,:),'Marker',Mar(count2),'MarkerSize',8,'LineWidth',1);
xlabel('Requests per Hour')
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
ylabel('Improvement [\%]')
ylim([0 50])
%xlim([0 2.2e4])

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
%h(5)=plot(NaN, NaN,'Color',CM(5,:),'LineWidth',2);
h(6)=plot(NaN, NaN,'Marker',Mar(1),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(7)=plot(NaN, NaN,'Marker',Mar(2),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(8)=plot(NaN, NaN,'Marker',Mar(3),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(9)=plot(NaN, NaN,'Marker',Mar(4),'MarkerSize',8,'Color','k','Linestyle', 'none');
%h(11)=plot(NaN, NaN,'Marker',Mar(5),'MarkerSize',8,'Color','k','Linestyle', 'none');
h(5)=plot(NaN, NaN,'Color','k','Linestyle', '--','LineWidth',2);
%%
%figure()
hold on; grid on; box on;
multiplicator = [0.005 0.03 0.05 0.1 0.2 0.4 0.8 1.6];%1.6
count2=0;
kk = 1.1*10^(-4);
nn=0.92;
for Delay = [1 2 5 10]%vec
count=0;
count2=count2+1;
for WaitingTime= [1 2 5 10]%vec
count = count+1;
    
load(strcat('NYC\results3\New_Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
set(gca,'ticklabelinterpreter','Latex','fontsize',14,'XTickLabel',[], 'XScale', 'log');
plot(TrackDems(:,1), 100- 100*TrackDems(:,2)./TrackDems(:,1) ,'Marker',Mar(count2),'MarkerSize',6,'Color',CM(count,:),'LineWidth',1);
xlabel('')
set(gca,'ticklabelinterpreter','Latex','fontsize',14)
ylabel('Pooled Rides [\%]')
ylim([10 100])
xlim([265 4.3e4])
    end
end
dems = [0:0.001:1]*10^6;
fun = 100*(kk*dems.^nn)./(1 + (kk*dems.^nn));
plot(dems/24,fun,'k','LineWidth',2,'Linestyle','--')

set(gca,'ticklabelinterpreter','Latex','fontsize',14)
%legend(h,'$\bar{t}=1$ min','$\bar{t}=2$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','Microscopic model[25]','$\bar{\delta}=1$ min','$\bar{\delta}=2$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min','NumColumns',2)
legend(h,'$\bar{t}=1$ min','$\bar{t}=2$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','Microscopic approach [25]','$\bar{\delta}=1$ min','$\bar{\delta}=2$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','NumColumns',2)

%% group together

for Delay =[2 5]% vec%
    
    for WaitingTime= vec %[1 2 5 10 15]%vec
        Improv = [];
        objs = [];
        TrackDems = [];
        TotG = [];
        Del = [];
        for multiplicator = [0.005 0.01 0.03 0.05 0.1 0.2 0.4 0.8] % 1.6 
            load(strcat('NYC/Results\Delay',num2str(Delay),'WTime',num2str(WaitingTime),'Dem',num2str(multiplicator),'.mat'),'TrackDems_temp','objs_temp','Improv_temp','Cumul_delay','TotGamma')
            Improv = [Improv Improv_temp];
            objs = [objs; objs_temp];
            TrackDems = [TrackDems; TrackDems_temp];
            TotG = [TotG TotGamma];
            Del = [Del Cumul_delay];
        end
        save(strcat('NYC/results3\New_Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv','TotG','Del')
    end
end
%%
subplot(2,1,2)
hold on; grid on; box on;
multiplicator = [0.005 0.01 0.03 0.05 0.1 0.2 0.4 0.8]; %1.6
count2=2;
for Delay = [2 5]%vec
count=0;
%count2=2;%count2+1;
for WaitingTime= [1 2 5 10]%vec
count = count+1;
    
load(strcat('NYC\results3\New_Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv','Del','TotG')
set(gca,'ticklabelinterpreter','Latex','fontsize',14)%,'XTickLabel',[]);
plot(TrackDems(:,1), Del./(TotG) ,'Marker',Mar(count2),'MarkerSize',6,'Color',CM(count,:),'LineWidth',1);
%yline(Delay,'LineWidth',1.5)
xlabel('Demands per Hour','fontsize',14)
set(gca,'ticklabelinterpreter','Latex','fontsize',14, 'XScale', 'log')
ylabel('Average Delay [min]')
ylim([0 2.1])
xlim([265 4.3e4])
end
    count2=3;
end
%legend(h,'$\bar{t}=1$ min','$\bar{t}=2$ min','$\bar{t}=5$ min','$\bar{t}=10$ min','$\bar{t}=15$ min','$\bar{\delta}=1$ min','$\bar{\delta}=2$ min','$\bar{\delta}=5$ min','$\bar{\delta}=10$ min','$\bar{\delta}=15$ min')
%set(gca,'ticklabelinterpreter','Latex','fontsize',16)
%%
city='NYC20'
fig=figure()
for iii=[1 2 ] % 7 8
Matt=[];
for Delay = vec
    temp = [];
for WaitingTime= vec
  
load(strcat(city,'\Results\New_Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
num=iii;
temp = [temp 100*(-objs(num,2)-objs(num,3) + objs(num,1))/objs(num,1)];
end
Matt = [Matt; temp];
end
Delay = vec;
WaitingTime= vec;
[XX,YY]=meshgrid(Delay,WaitingTime);
nexttile
Dems = roundn(TrackDems(iii,1),2);

contourf(XX,YY,Matt)
caxis([10,50]); 
title(strcat ( num2str(Dems) ,' Demands/h'),'FontSize', 22,'interpreter','latex' )
caxis([10,50]);
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
caxis(h,[10,50]); 
%axis equal
ylabel(h,'Maximum Delay $\bar{\delta}$ [min]','FontSize', 32,'interpreter','latex')
xlabel(h,'Maximum Waiting Time $\bar{t}$ [min]','FontSize', 32,'interpreter','latex')
set(gca,'FontSize',28)
cc.Label.FontSize=30;
