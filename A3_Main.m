clc
clear all
city='NYC25';
load(strcat(city,'/Graphs.mat');
Adj = adjacency(G_road);
Binc = incidence(G_road); 
[N_nodes,N_edges]=size(Binc);

DemandS= DemandS/24; %daily to hourly
OriginalDemand= DemandS;
TotDems = sum(DemandS,'all');

%% Layer 2
load('SF/MatL2.mat')
%%
for WaitingTime = [1 2 5 10 15]; %in min
    for Delay = [1 2 5 10 15]; % in min
        %%
        Improv =  [];
        objs = [];
        TrackDems = [];
        for mult= [0.05 0.1 0.2 0.4 0.8 1.6]
            DemandS =  mult* OriginalDemand;
            Demands_rp = zeros(N_nodes,N_nodes);
            beta = zeros(N_nodes,N_nodes,N_nodes,N_nodes);
            gamma = zeros(N_nodes,N_nodes,N_nodes,N_nodes);
            
            for iii = 1:size(sol2_LC,1)
                jj1 = sol2_LC(iii,4);
                ii1 = sol2_LC(iii,5);
                jj2 = sol2_LC(iii,6);
                ii2 = sol2_LC(iii,7);
                if ii1==ii2 && jj1==jj2
                    beta(jj1,ii1,jj2,ii2) = DemandS(ii1,jj1);
                    gamma(jj1,ii1,jj2,ii2) = beta(jj1,ii1,jj2,ii2)*probcomb(beta(jj1,ii1,jj2,ii2),beta(jj1,ii1,jj2,ii2),WaitingTime);
                    temp_dem=zeros(N_nodes,N_nodes);
                    temp_dem(ii1,jj1)= gamma(jj1,ii1,jj2,ii2)/2;
                    %temp_dem(jj1,jj1)= -gamma(jj1,ii1,jj2,ii2)/2;
                    Demands_rp = Demands_rp + temp_dem;
                    DemandS(ii1,jj1) = DemandS(ii1,jj1) - gamma(jj1,ii1,jj2,ii2);
                    %DemandS(ii1,ii1) = DemandS(ii1,ii1) + beta4D(jj1,ii1,jj2,ii2);
                else
                    if sol2_LC(iii,2) < Delay && sol2_LC(iii,3) < Delay
                        beta(jj1,ii1,jj2,ii2) = DemandS(ii1,jj1);
                        beta(jj2,ii2,jj1,ii1) = DemandS(ii2,jj2);
                        gamma(jj1,ii1,jj2,ii2) = min(beta(jj1,ii1,jj2,ii2),beta(jj2,ii2,jj1,ii1))*probcomb(beta(jj1,ii1,jj2,ii2),beta(jj2,ii2,jj1,ii1),WaitingTime);
                        gamma(jj2,ii2,jj1,ii1) = gamma(jj1,ii1,jj2,ii2);
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
                        Demands_rp = Demands_rp + gamma(jj1,ii1,jj2,ii2)* Gamma0;
                        DemandS(ii1,jj1) = DemandS(ii1,jj1) - gamma(jj1,ii1,jj2,ii2);
                        DemandS(ii2,jj2) = DemandS(ii2,jj2) - gamma(jj1,ii1,jj2,ii2);
                        
                    end
                    
                end
                %                     duplic = sum(sol2_LC(:,4:7) == [jj1 ii1 jj2 ii2],2);
                %                     delet = find(duplic==4);
                %                     sol2_LC(delet,:)=[];
                %                     size(sol2_LC)
            end
            %%
            
            solBase=LTIFM_reb(mult*OriginalDemand);
            solNP = LTIFM_reb(DemandS);
            solRP = LTIFM_reb(Demands_rp);
            TrackDems = [TrackDems; sum(mult*OriginalDemand,'all'), sum(DemandS,'all'),sum(Demands_rp,'all')];
            objs = [objs; solBase.obj, solNP.obj, solRP.obj];
            Improv = [Improv (solNP.obj + solRP.obj)/solBase.obj];
        end
        save(strcat('Results/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'.mat'),'TrackDems','objs','Improv')
    end
end
%%
