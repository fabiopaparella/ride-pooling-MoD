%% plot graphs
load('Graphs.mat')
b = load('Graphs40.mat')
ADJ=adjacency(G_road);
figure(1)
hold on; grid on; box on;
plot(graph(ADJ+ADJ'),'YData',NodesLoc(:,1)/1000,'XData',NodesLoc(:,2)/1000,'Marker','.','Linewidth',1,'EdgeColor','k')
%pp=plot(G_road,'XData',NodesLoc(:,1),'YData',NodesLoc(:,2),'Linewidth',1)
ylim([-2 6])
axis equal
xlabel('kilometers [km]')
ylabel('kilometers [km]')
grid on
set(gca,'ticklabelinterpreter','Latex','fontsize',16)

ADJ2=adjacency(b.G_road);
%figure(2)
plot(graph(ADJ2+ADJ2'),'YData',b.NodesLoc(:,1)/1000,'XData',b.NodesLoc(:,2)/1000,'Marker','.','Linewidth',1,'EdgeColor','r')
%pp=plot(G_road,'XData',NodesLoc(:,1),'YData',NodesLoc(:,2),'Linewidth',1)
ylim([-2 6])
axis equal
xlabel('kilometers [km]')
ylabel('kilometers [km]')
grid on
set(gca,'ticklabelinterpreter','Latex','fontsize',16)

