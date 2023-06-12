clc
clear all
city='NYC20';
load(strcat(city,'/Graphs.mat'));
load(strcat(city,'/solPart_',city,'.mat'));
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 4
load(strcat(city,'/MatL3.mat'))
mkdir(strcat(city,'/L4'))
List = sol3_LC(:,5:10);
sol4_LC = [];
for jj1=1:N_nodes %18
    for ii1= 1:N_nodes %1
        sol4_LC_temp= zeros(N_nodes^5,21);
        counter=1;
        ii1
        for xx = 1:size(List,1)
            if ~any([ii1==jj1,ii1==List(xx,1),ii1==List(xx,3),ii1==List(xx,5),List(xx,2)==jj1,List(xx,4)==jj1,List(xx,6)==jj1])
                %sol4_LC_temp1 = LTIFM4_SP(jj1,ii1,List(xx,1),List(xx,2),List(xx,3),List(xx,4),List(xx,5),List(xx,6),solPart);
                %LTIFM4_SP(jj1,List(xx,2),List(xx,1),ii1,List(xx,3),List(xx,4),List(xx,5),List(xx,6),solPart);
                %LTIFM4_SP(jj1,List(xx,4),List(xx,1),List(xx,2),List(xx,3),ii1,List(xx,5),List(xx,6),solPart);
                %LTIFM4_SP(jj1,List(xx,6),List(xx,1),List(xx,2),List(xx,3),List(xx,4),List(xx,5),ii1,solPart);];
                %[aa,bb]=min(sol4_LC_temp1(:,1));
                %sol4_LC_temp(counter,:) = sol4_LC_temp1(bb,:);
                sol4_LC_temp(counter,:) = LTIFM4_SP(jj1,ii1,List(xx,1),List(xx,2),List(xx,3),List(xx,4),List(xx,5),List(xx,6),solPart);
                counter = counter +1;
                
            end
        end
        sol4_LC_temp( sol4_LC_temp(:,1)==0,: ) = []; %filter out zero obj
        sol4_LC_temp( sol4_LC_temp(:,2) > 10,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,3) > 10,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,4) > 10,: ) = []; %filter out above 20 delay
        sol4_LC_temp( sol4_LC_temp(:,5) > 10,: ) = []; %filter out above 20 delay
        %sol4_LC_temp = sortrows(sol4_LC_temp);
        parsave(jj1,ii1,sol4_LC_temp,city)%, '-v7.3'
        
    end
end