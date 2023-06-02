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
load('SF/MatL2.mat')
List = sol2_LC(:,4:7);
sol3_LC = [];
List2 = [];
List3 = [];
count=0;
for jj1=1:N_nodes %18
    for ii1=1:N_nodes%15:N_nodes %1
        count= count+1;
        % find compatible rides of jj1,ii1 in L2 rides list
        col1 =find(List(:,1) == jj1);
        col2 =find(List(:,2) == ii1);
        int1 = intersect(col1,col2);
        col3 =find(List(:,3) == jj1);
        col4 =find(List(:,4) == ii1);
        int2 = intersect(col3,col4);
        % list of compatible rides
        List1 = [ List(int1,3), List(int1,4) ; List(int2,1), List(int2,2) ];
        List2  = [];
        List3 = [List3; List2];
        
        
    end
end
%%
        for xx = 1:size(List,1)
            if ~any([ii1==jj1,ii1==List(xx,1),ii1==List(xx,3),List(xx,2)==jj1,List(xx,4)==jj1])        
                %sol3_LC{ii1,jj2,ii2,jj3,ii3} = LTIFM3_SP(jj1,ii1,jj2,ii2,jj3,ii3,solPart);
                sol3_LC_temp(counter,:) = LTIFM3_SP(jj1,ii1,List(xx,1),List(xx,2),List(xx,3),List(xx,4),solPart);
                counter = counter +1;
           
            end
        end
 
sol3_LC_temp( sol3_LC_temp(:,1)==0,: ) = []; %filter out zero obj
sol3_LC_temp( sol3_LC_temp(:,2) > 15,: ) = []; %filter out above 20 delay
sol3_LC_temp( sol3_LC_temp(:,3) > 15,: ) = []; %filter out above 20 delay   
sol3_LC_temp( sol3_LC_temp(:,4) > 15,: ) = []; %filter out above 20 delay   
sol3_LC_temp = sortrows(sol3_LC_temp);
save(strcat('SF/MatL3_',num2str(jj1),'.mat'),'sol3_LC_temp')%, '-v7.3')

sol3_LC = [sol3_LC; sol3_LC_temp];
sol3_LC = sortrows(sol3_LC);
save('SF/MatL3.mat','sol3_LC')%, '-v7.3')