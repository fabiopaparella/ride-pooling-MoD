clc
clear all
city = 'SF';
load(strcat(city,'/Graphs.mat'));
load(strcat(city,'/solPart_',city,'.mat'));
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

%% Layer 2
mkdir(strcat(city,'/L2'))
parfor jj1=1:N_nodes %18
    sol2_LC = zeros(N_nodes*N_nodes*N_nodes,11);   %NYC
    counter=1;
    jj1
   for ii1=1:N_nodes%15:N_nodes %1
       ii1
      for ii2=ii1:N_nodes %12%
         for jj2=jj1:N_nodes %20  
            if ~any([ii2==jj2,ii1==jj2,ii2==jj1,ii1==jj1,DemandS(ii1,jj1)==0,DemandS(ii2,jj2)==0])
               opti = sortrows([ LTIFM2_SP(jj1,ii1,jj2,ii2,solPart); LTIFM2_SP(jj2,ii2,jj1,ii1,solPart)]);
               sol2_LC(counter,:) = opti(1,:); % matrix with objective, delays, order
               counter = counter+1;
            end  
         end
      end
   end
sol2_LC( sol2_LC(:,1) == 0,: ) = []; %filter out zero obj
sol2_LC( sol2_LC(:,2) > 20,: ) = []; %filter out above 20 delay
sol2_LC( sol2_LC(:,3) > 20,: ) = []; %filter out above 20 delay
parsave2(strcat(city,'/L2/MatL2_',num2str(jj1),'.mat'),sol2_LC) 
   
end
%%
