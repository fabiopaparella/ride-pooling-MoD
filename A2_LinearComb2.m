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
%% Layer 2
%sol2_LC{N_nodes,N_nodes,N_nodes,N_nodes}={};
sol2_LC = zeros(N_nodes*N_nodes*N_nodes*N_nodes,11);   
counter=1;
for jj1=1:N_nodes %18
    jj1
   for ii1=1:N_nodes%15:N_nodes %1
      for ii2=1:N_nodes %12%
         for jj2=1:N_nodes %20  
            if ~any([ii2==jj2,ii1==jj2,ii2==jj1,ii1==jj1])
               %sol2_LC{jj1,ii1,jj2,ii2} = LTIFM2_SP(jj1,ii1,jj2,ii2,solPart);  
               sol2_LC(counter,:) = LTIFM2_SP(jj1,ii1,jj2,ii2,solPart); % matrix with objective, delays, order
               counter = counter+1;
            end  
         end
      end
   end
end
%%
sol2_LC( sol2_LC(:,1)==0,: ) = []; %filter out zero obj
sol2_LC( sol2_LC(:,2) > 15,: ) = []; %filter out above 20 delay
sol2_LC( sol2_LC(:,3) > 15,: ) = []; %filter out above 20 delay
sol2_LC = sortrows(sol2_LC);
%% eliminate duplicates
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
sol2_LC( sol2_LC(:,1)==0,: ) = [];

save('SF/MatL2.mat','sol2_LC')