clear all
city='NYC20';
load(strcat(city,'/Graphs.mat'));
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 3 join together
sol4_LC = [];
for jj1= 1 : N_nodes
    for ii1 = 1: N_nodes
        load(strcat(city,'/L4/MatL4_',num2str(jj1),'_',num2str(ii1),'.mat'),'sol4_LC_temp')%, '-v7.3')
        sol4_LC = [sol4_LC; sol4_LC_temp];
    end
end
sol4_LC = sortrows(sol4_LC);
save(strcat(city,'/MatL4.mat'),'sol4_LC')%, '-v7.3')