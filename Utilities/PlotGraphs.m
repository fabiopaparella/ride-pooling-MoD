%% plot graphs
subplot(1,4,1)
load('Graphs.mat')
b = load('Graphs20.mat')
ADJ=adjacency(G_road);
hold on; grid on; box on;
plot(graph(ADJ+ADJ'),'YData',NodesLoc(:,2)/1000,'XData',NodesLoc(:,1)/1000,'Marker','.','Linewidth',1,'EdgeColor','k')
%pp=plot(G_road,'XData',NodesLoc(:,1),'YData',NodesLoc(:,2),'Linewidth',1)
xlim([-5 5])
ylim([2 20])
axis equal
%xlabel('kilometers [km]')
%ylabel('kilometers [km]')
xticklabels({});
yticklabels({});
set(gca,'ticklabelinterpreter','Latex','fontsize',16)

ADJ2=adjacency(b.G_road);
p=plot(graph(ADJ2+ADJ2'),'YData',b.NodesLoc(:,2)/1000,'XData',b.NodesLoc(:,1)/1000,'Marker','.','Linewidth',1,'EdgeColor','r')
p.NodeLabel = {};
%pp=plot(G_road,'XData',NodesLoc(:,1),'YData',NodesLoc(:,2),'Linewidth',1)
xlim([-5 5])
ylim([2 20])
axis equal
%xlabel('kilometers [km]')
%ylabel('kilometers [km]')
xticklabels({});
yticklabels({});
set(gca,'ticklabelinterpreter','Latex','fontsize',16)
title('20 Nodes')

