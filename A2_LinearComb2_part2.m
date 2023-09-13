clc
clear all
city = 'SF';
load(strcat(city,'/Graphs.mat'));
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 2
sol2_LC = [];
for jj1=1:N_nodes %18
    jj1
    A = load(strcat(city,'/L2/MatL2_',num2str(jj1),'.mat'),'sol2_LC');
    sol2_LC = [sol2_LC ; A.sol2_LC]; %A.file
end
%%
sol2_LC = sortrows(sol2_LC);
sol2_LC( sol2_LC(:,1) >= 0,: ) = [];
save(strcat(city,'/MatL2.mat'),'sol2_LC','-v7.3')