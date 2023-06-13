%% Change log (Leo)
% - Free flow time is now updated form NYC20_FreeFlowTime.mat
% - Supress output

%%%%% Update leo
% clc
% clear all
%%%%% 

%% this script computes the solution of problem 1 for every OD pair. aka, the shortest path betweene every couple of nodes
city = 'NYC20'; % 'SF'
load(strcat(city,'/Graphs.mat'));
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
DemandS=ones(N_nodes)-eye(N_nodes);
%G_road.Edges.Weight=FreeFlowTime';

%%%%% Update leo
load(strcat(city,'/FlowTime.mat'));
G_road.Edges.Weight=FlowTime';
%%%%%

solPart{N_nodes,N_nodes}='';

for ii=1:N_nodes
    
%%%%% Update leo    
%     ii
%%%%%
    for jj=1:N_nodes
            Dems = zeros(N_nodes);
            Dems(ii,jj) = 1;
            Dems(jj,jj) = -1;
            if ii==jj 
                Dems(jj,jj) = -0;
            end
            [sp,D] = shortestpath(G_road,jj,ii);
            solPart{jj,ii}.obj = D;
            solPart{jj,ii}.Dem = sparse(Dems);
            solPart{jj,ii}.IndividualTimes = D;
    end
end
save(strcat(city,'/solPart_',city,'.mat'),'solPart')