clc
clear all
load 'SF/Graphs.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
DemandS=ones(N_nodes)-eye(N_nodes);

solPart{N_nodes,N_nodes}='';
for ii=1:N_nodes
    for jj=1:N_nodes
        if ii ~= jj
            Dems = zeros(N_nodes);
            Dems(ii,jj) = 1;
            solPart{jj,ii} = LTIFM(Dems);
        end
    end
end
save('solPart_backup.mat','solPart')