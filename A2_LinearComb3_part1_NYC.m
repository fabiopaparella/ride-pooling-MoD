clc
clear all
city='NYC20';
load(strcat(city,'/Graphs.mat'));
load(strcat(city,'/solPart_',city,'.mat'));
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 3
%sol3_LC{20,N_nodes,N_nodes,N_nodes,N_nodes}={};
load(strcat(city,'/MatL2.mat'))
List = sol2_LC(:,4:7);
sol3_LC = [];
mkdir(strcat(city,'/L3'))
for jj1=1:N_nodes %18
    sol3_LC_temp= zeros(40^5,16);
    counter=1;
    for ii1=1:N_nodes%15:N_nodes %1
        ii1
        for xx = 1:size(List,1)
            if ~any([ii1==jj1,ii1==List(xx,1),ii1==List(xx,3),List(xx,2)==jj1,List(xx,4)==jj1])        
                %sol3_LC{ii1,jj2,ii2,jj3,ii3} = LTIFM3_SP(jj1,ii1,jj2,ii2,jj3,ii3,solPart);
                sol3_LC_temp(counter,:) = LTIFM3_SP(jj1,ii1,List(xx,1),List(xx,2),List(xx,3),List(xx,4),solPart);
                counter = counter +1;
           
            end
        end
    end
sol3_LC_temp( sol3_LC_temp(:,1)==0,: ) = []; %filter out zero obj
sol3_LC_temp( sol3_LC_temp(:,2) > 10,: ) = []; %filter out above 20 delay
sol3_LC_temp( sol3_LC_temp(:,3) > 10,: ) = []; %filter out above 20 delay   
sol3_LC_temp( sol3_LC_temp(:,4) > 10,: ) = []; %filter out above 20 delay   
sol3_LC_temp = sortrows(sol3_LC_temp);
save(strcat(city,'/L3/MatL3_',num2str(jj1),'.mat'),'sol3_LC_temp')%, '-v7.3')

%sol3_LC = [sol3_LC; sol3_LC_temp];
%sol3_LC = sortrows(sol3_LC);
%save('SF/MatL3.mat','sol3_LC')%, '-v7.3')
end