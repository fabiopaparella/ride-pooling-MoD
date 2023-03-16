clc
clear all
load 'SF/Graphs.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
DemandS=ones(N_nodes)-eye(N_nodes);

load('solPart.mat')
load('solShared_Light.mat')
%% Layer 2
sol2_Light{N_nodes,N_nodes,N_nodes,N_nodes}={};
   
for jj1=1:N_nodes %18
    for ii1=1:N_nodes%15:N_nodes %1
        for ii2=1:N_nodes %12%
            for jj2=1:N_nodes %20
                if isempty(sol2_Light{jj2,ii2,jj1,ii1})
                
                if ii1 ~= ii2 && jj1~=jj2 &&  ii1~=jj1 && ii2~=jj2 && ii1~=jj2 && ii2~=jj1
                
                sol2_Light{jj1,ii1,jj2,ii2} = LTIFM3_Light(jj1,ii1,jj2,ii2);
                sol2_Light{jj2,ii2,jj1,ii1} = sol2_Light{jj1,ii1,jj2,ii2};
                
                elseif ii1 == ii2 && jj1==jj2 && ii1~=jj1
                Dems = zeros(N_nodes);
                Dems(ii1,jj1) = 1;
                Dems(ii2,jj2) = 1;
                sol2_Light{jj1,ii1,jj2,ii2} = LTIFM(Dems);
                else 
                sol2_Light{jj1,ii1,jj2,ii2} = [];   
                end           
                end
            end
        end
    end
end
%%
% for jj1=1:N_nodes %18
%     for ii1=1:N_nodes%15:N_nodes %1
%         for ii2=1:N_nodes %12%
%             for jj2=1:N_nodes %20
%                 if ~isempty(sol2_Light{jj1,ii1,jj2,ii2})
%                 
%                 if ~isstruct(sol2_Light{jj1,ii1,jj2,ii2})
%                 sol2_Light{jj1,ii1,jj2,ii2} = [];
%                 end
%                 
%                 end
%             end
%         end
%     end
% end

%%
save('solShared_Light.mat','sol2_Light')