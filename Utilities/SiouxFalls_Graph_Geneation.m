clear all
clc
load 'SF/SiouxFalls.mat';
load 'SF/SiouxFalls_coord.mat';
load 'SF/SiouxFalls_dem.mat';
%%
%FreeFlowTime=FreeFlowTime; % in hours
Length=Length*1000; %km to meters
G_road = digraph(Initial_Node,Terminal_Node,Length);
NodesLoc = [CoordX', CoordY'];
%NodesLoc = LatLon2XYs([CoordX;CoordY],448)/1000;
Adj = adjacency(G_road);
Inc = incidence(G_road);

% plot(G_road,'XData',NodesLoc(:,1),'YData',NodesLoc(:,2),'MarkerSize',0.1)
% axis square
% set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])

save('Graphs','G_road','DemandS','NodesLoc','FreeFlowTime')


