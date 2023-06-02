clc
clear all
load 'SF/Graphs.mat';
load('SF/solPart_SP.mat');
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
DemandS=ones(N_nodes)-eye(N_nodes);

%load('SF/solShared_LC.mat') % the file containts the linear combinations of the OD pairs computed in A1.
% we load an empty or partially computed matrix to split the computation in
% many runs
%% Layer 3
%sol3_LC{20,N_nodes,N_nodes,N_nodes,N_nodes}={};
load('SF/MatL3.mat')
List = sol3_LC(:,5:10);
sol4_LC = [];

for jj1=1%N_nodes %18
    parfor ii1= 16:N_nodes%15:N_nodes %1
        sol4_LC_temp= zeros(N_nodes^5,21);
        counter=1;
        ii1
        for xx = 1:size(List,1)
            if ~any([ii1==jj1,ii1==List(xx,1),ii1==List(xx,3),ii1==List(xx,5),List(xx,2)==jj1,List(xx,4)==jj1,List(xx,6)==jj1])
                %sol3_LC{ii1,jj2,ii2,jj3,ii3} = LTIFM3_SP(jj1,ii1,jj2,ii2,jj3,ii3,solPart);
                sol4_LC_temp1 = [ LTIFM4_SP(jj1,ii1,List(xx,1),List(xx,2),List(xx,3),List(xx,4),List(xx,5),List(xx,6),solPart);
                    LTIFM4_SP(jj1,List(xx,2),List(xx,1),ii1,List(xx,3),List(xx,4),List(xx,5),List(xx,6),solPart);
                    LTIFM4_SP(jj1,List(xx,4),List(xx,1),List(xx,2),List(xx,3),ii1,List(xx,5),List(xx,6),solPart);
                    LTIFM4_SP(jj1,List(xx,6),List(xx,1),List(xx,2),List(xx,3),List(xx,4),List(xx,5),ii1,solPart);];
                [aa,bb]=min(sol4_LC_temp1(:,1));
                sol4_LC_temp(counter,:) = sol4_LC_temp1(bb,:);
                counter = counter +1;
                
            end
        end
        sol4_LC_temp( sol4_LC_temp(:,1)==0,: ) = []; %filter out zero obj
        sol4_LC_temp( sol4_LC_temp(:,2) > 15,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,3) > 15,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,4) > 15,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,5) > 15,: ) = []; %filter out above 20 delay
        sol4_LC_temp = sortrows(sol4_LC_temp);
        %save(strcat('SF/L4/MatL4_',num2str(jj1),'_',num2str(ii1),'.mat'),sol4_LC_temp)%, '-v7.3')
        parsave(jj1,ii1,sol4_LC_temp)%, '-v7.3'
        %sol4_LC = [sol4_LC; sol4_LC_temp];
        %sol4_LC = sortrows(sol4_LC);
        %save('SF/MatL4.mat','sol4_LC')%, '-v7.3')
    end
end