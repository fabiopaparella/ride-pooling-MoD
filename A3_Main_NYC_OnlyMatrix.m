clc
clear all
load 'NYC/Graphs.mat';
load 'NYC/Demm.mat';
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);
OriginalDemand= DemandS;
TotDems = sum(DemandS,'all');

%% Layer 2
load('NYC/MatL2.mat')
%%
for WaitingTime = [2 5]; %in min
    for Delay = [2]; % in min     
        for mult= [0.005 0.01 0.03 0.05 0.1 0.2 0.4 0.8 1.6] %0.05
            Cumul_delay = 0;
            TotGamma = 0;
            DemandS =  mult* OriginalDemand;
            Demands_rp = zeros(N_nodes,N_nodes);
            
            for iii = 1:100%size(sol2_LC,1)
                jj1 = sol2_LC(iii,4);
                ii1 = sol2_LC(iii,5);
                jj2 = sol2_LC(iii,6);
                ii2 = sol2_LC(iii,7);
                if ii1==ii2 && jj1==jj2
                    gamma = DemandS(ii1,jj1)*probcomb(DemandS(ii1,jj1),DemandS(ii1,jj1),WaitingTime);
                    temp_dem=zeros(N_nodes,N_nodes);
                    temp_dem(ii1,jj1)= gamma/2;
                    Demands_rp = Demands_rp + temp_dem;
                    DemandS(ii1,jj1) = DemandS(ii1,jj1) - gamma;
                    Cumul_delay = Cumul_delay + sol2_LC(iii,2)*gamma + sol2_LC(iii,3)*gamma;
                    TotGamma = TotGamma + gamma;
                else
                    if sol2_LC(iii,2) < Delay && sol2_LC(iii,3) < Delay
                        gamma = min(DemandS(ii1,jj1),DemandS(ii2,jj2))*probcomb(DemandS(ii1,jj1),DemandS(ii2,jj2),WaitingTime);
                        Gamma0 = zeros(N_nodes,N_nodes);
                        
                        if sol2_LC(iii,8:11) == [1 2 1 2]
                            Gamma0(jj2,jj1) = 1;
                            Gamma0(ii1,jj2) = 1;
                            Gamma0(ii2,ii1) = 1;
                        elseif sol2_LC(iii,8:11) == [1 2 2 1]
                            Gamma0(jj2,jj1) = 1;
                            Gamma0(ii2,jj2) = 1;
                            Gamma0(ii1,ii2) = 1;
                        end
                        if ii1==ii2
                            Gamma0(ii1,ii2) = 0;
                        elseif jj1==jj2
                            Gamma0(jj1,jj2) = 0;
                        end
                        Demands_rp = Demands_rp + gamma* Gamma0;
                        DemandS(ii1,jj1) = DemandS(ii1,jj1) - gamma;
                        DemandS(ii2,jj2) = DemandS(ii2,jj2) - gamma;
                        Cumul_delay = Cumul_delay + sol2_LC(iii,2)*gamma + sol2_LC(iii,3)*gamma;
                        TotGamma = TotGamma + gamma;
                    end
                    
                end
            end
            %%
            Scaled_dem = mult*OriginalDemand;
%             solBase=LTIFM_reb(mult*OriginalDemand);
%             solNP = LTIFM_reb(DemandS);
%             solRP = LTIFM_reb(Demands_rp);
%             TrackDems_temp = [sum(mult*OriginalDemand,'all'), sum(DemandS,'all'),sum(Demands_rp,'all')]
%             TrackDems = [TrackDems; TrackDems_temp];
%             objs_temp = [solBase.obj, solNP.obj, solRP.obj];
%             objs = [objs; objs_temp];
%             Improv_temp = (solNP.obj + solRP.obj)/solBase.obj;
%             Improv = [Improv Improv_temp];
              save(strcat('NYC/results3/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'Dem',num2str(mult),'.mat'),'Scaled_dem','DemandS','Demands_rp','Cumul_delay','TotGamma')
            
        end
        %    save(strcat('NYC/Results/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
    end
end
%%
