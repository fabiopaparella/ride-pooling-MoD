clc
clear all
load 'NYC/Graphs.mat';
load 'NYC/Demm.mat'
load('NYC/solPart_NYC.mat');
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 2
sol2_LC = [];
for jj1=1:N_nodes %18
    jj1
    A = load(strcat('NYC/L2/MatL2_',num2str(jj1),'.mat'),'sol2_LC') 
    sol2_LC = [sol2_LC ; A.sol2_LC];
end
%%
sol2_LC = sortrows(sol2_LC);
    % eliminate duplicates
for ii= 1 : size(sol2_LC,1)
    if sol2_LC(ii,1) ~= 0 && sol2_LC(ii,4)~= sol2_LC(ii,6) && sol2_LC(ii,5)~= sol2_LC(ii,7)
        jj1 = sol2_LC(ii,4);
        ii1 = sol2_LC(ii,5);
        jj2 = sol2_LC(ii,6);
        ii2 = sol2_LC(ii,7);
        dup=find(sum(sol2_LC(:,4:7) == [jj2 ii1 jj1 ii2],2)==4);
        sol2_LC(dup,1) = 0;
    end
        
end
%%
sol2_LC( sol2_LC(:,1) >= -1,: ) = [];
save('NYC/MatL2_1obj.mat','sol2_LC','-v7.3') 
   
