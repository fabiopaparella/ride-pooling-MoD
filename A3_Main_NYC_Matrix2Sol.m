clc
clear all

%%
for WaitingTime = [10]; %in min
    for Delay = [15]; % in min      
        for mult= [0.005] % 0.05 0.1 0.2 0.4 0.8 1.6]
            load(strcat('NYC/raw_results/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'Dem',num2str(mult),'.mat'))        
            solBase=LTIFM_reb(Scaled_dem);
            solNP = LTIFM_reb(DemandS);
            solRP = LTIFM_reb(Demands_rp);
            TrackDems_temp = [sum(Scaled_dem,'all'), sum(DemandS,'all'),sum(Demands_rp,'all')]
            objs_temp = [solBase.obj, solNP.obj, solRP.obj];
            Improv_temp = (solNP.obj + solRP.obj)/solBase.obj;
            save(strcat('NYC/Results/Delay',num2str(Delay),'WTime',num2str(WaitingTime),'Dem',num2str(mult),'.mat'),'TrackDems_temp','objs_temp','Improv_temp','Cumul_delay','TotGamma')
            
        end
    end
end
%%
