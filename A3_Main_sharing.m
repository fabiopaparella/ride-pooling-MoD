clc
clear all
load 'SF/Graphs.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

DemandS= DemandS/24; %daily to hourly
OriginalDemand= DemandS;
TotDems = sum(DemandS,'all');

%% Layer 2
load('SF/solShared_Light.mat')
%% Best option
bestSol={};
NpSol={};
DiffObj=[];
for ii1=2:N_nodes
    for jj1=1:N_nodes
        for ii2=1:N_nodes
            for jj2=1:N_nodes
                
                if isempty(sol2_Light{jj1,ii1,jj2,ii2})
                DiffObj(jj1,ii1,jj2,ii2) = 0;
                
                elseif ii1==ii2 && jj1==jj2 && ii1~=jj1 && ~isempty(sol2_Light{jj1,ii1,jj2,ii2})
                bb=sol2_Light{jj1,ii1,jj2,ii2};
                DiffObj(jj1,ii1,jj2,ii2) = bb(1).obj;
                
                else
                bb=sol2_Light{jj1,ii1,jj2,ii2};
                [mina,minb]=find(min([bb.obj])==[bb.obj]);
                if length(minb)~= 1 
                    minb(1:end-1)=[];
                end
                bestSol{jj1,ii1,jj2,ii2} = bb(minb);
                NpSol{jj1,ii1,jj2,ii2} = bb(1);
                DiffObj(jj1,ii1,jj2,ii2) = bb(1).obj - bb(minb).obj;
                end
            end
        end
    end
end
%%
load('SF/solShared_Light.mat')
OldObj=DiffObj;
%%
for WaitingTime = [1 5 10 15]; %in min


for Delay = [1 5 10 15]; % in min
%%
Improv =  [];
objs = [];
TrackDems = [];

for mult= 0.1:0.2:2.1
DiffObj = OldObj;
DemandS =  mult* OriginalDemand;
Demands_rp = zeros(N_nodes,N_nodes);
alpha4D = zeros(N_nodes,N_nodes,N_nodes,N_nodes);
beta4D = zeros(N_nodes,N_nodes,N_nodes,N_nodes);
alpha2D = zeros(N_nodes,N_nodes);
beta2D = zeros(N_nodes,N_nodes);



while max(DiffObj,[],'all','linear') > 0
[val,ind]=max(DiffObj,[],'all','linear');
[jj1,ii1,jj2,ii2] = ind2sub([N_nodes N_nodes N_nodes N_nodes],ind);

if ii1==ii2 && jj1==jj2
alpha4D(jj1,ii1,jj2,ii2) = DemandS(ii1,jj1);

if alpha4D(jj1,ii1,jj2,ii2)==0
    beta4D(jj1,ii1,jj2,ii2) = 0;
else
beta4D(jj1,ii1,jj2,ii2) = alpha4D(jj1,ii1,jj2,ii2)*probcomb(alpha4D(jj1,ii1,jj2,ii2),alpha4D(jj1,ii1,jj2,ii2),WaitingTime);
temp_dem=zeros(N_nodes,N_nodes);
temp_dem(ii1,jj1)= beta4D(jj1,ii1,jj2,ii2)/2;
temp_dem(jj1,jj1)= -beta4D(jj1,ii1,jj2,ii2)/2;

Demands_rp = Demands_rp + temp_dem;
DemandS(ii1,jj1) = DemandS(ii1,jj1) - beta4D(jj1,ii1,jj2,ii2);
%DemandS(ii1,ii1) = DemandS(ii1,ii1) + beta4D(jj1,ii1,jj2,ii2);
end
DiffObj(jj1,ii1,jj2,ii2)=0;

else
    
    if NpSol{jj1,ii1,jj2,ii2}.TimeOD1 + Delay > bestSol{jj1,ii1,jj2,ii2}.TimeOD1 && NpSol{jj1,ii1,jj2,ii2}.TimeOD2 + Delay > bestSol{jj1,ii1,jj2,ii2}.TimeOD2
alpha4D(jj1,ii1,jj2,ii2) = DemandS(ii1,jj1);
alpha4D(jj2,ii2,jj1,ii1) = DemandS(ii2,jj2);
if alpha4D(jj1,ii1,jj2,ii2)==0 || alpha4D(jj2,ii2,jj1,ii1) == 0
beta4D(jj1,ii1,jj2,ii2) = 0;
beta4D(jj2,ii2,jj1,ii1)=0;
else
beta4D(jj1,ii1,jj2,ii2) = min(alpha4D(jj1,ii1,jj2,ii2),alpha4D(jj2,ii2,jj1,ii1))*probcomb(alpha4D(jj1,ii1,jj2,ii2),alpha4D(jj2,ii2,jj1,ii1),WaitingTime);
beta4D(jj2,ii2,jj1,ii1) = beta4D(jj1,ii1,jj2,ii2);
Demands_rp = Demands_rp + beta4D(jj1,ii1,jj2,ii2)* bestSol{jj1,ii1,jj2,ii2}.Dem;
end
DemandS(ii1,jj1) = DemandS(ii1,jj1) - beta4D(jj1,ii1,jj2,ii2);
DemandS(ii2,jj2) = DemandS(ii2,jj2) - beta4D(jj1,ii1,jj2,ii2);
%DemandS(ii1,ii1) = DemandS(ii1,jj1) + beta4D(jj1,ii1,jj2,ii2);
%DemandS(ii2,ii2) = DemandS(ii2,jj2) + beta4D(jj1,ii1,jj2,ii2);
    end
DiffObj(jj1,ii1,jj2,ii2)=0;
DiffObj(jj2,ii2,jj1,ii1)=0;

end
end
%%

solBase=LTIFM_reb(mult*OriginalDemand);
solNP = LTIFM_reb(DemandS);
solRP = LTIFM_reb(Demands_rp);
TrackDems = [TrackDems; sum(mult*OriginalDemand,'all'), sum(DemandS,'all'),sum(Demands_rp,'all')];
objs = [objs; solBase.obj, solNP.obj, solRP.obj]; 
Improv = [Improv (solNP.obj + solRP.obj)/solBase.obj];
end
save(strcat('Results_reb/RebDelay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
end
end
%%
