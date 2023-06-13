%% Edogenous congestion bilevel optimization

%% Parameters
clear;
city = 'NYC20';

%% Initialization
fprintf('Initialization.\n');
warning('off', 'MATLAB:MKDIR:DirectoryExists');

% Write 'FreeFlowTime' and initial 'FlowTime'
load(strcat(city,'/Graphs.mat'),'FreeFlowTime');
save(strcat(city,'/FreeFlowTime.mat'),'FreeFlowTime');
load(strcat(city,'/FlowTime.mat'),'FlowTime');
% FlowTime = FreeFlowTime;
% save(strcat(city,'/FlowTime.mat'),'FlowTime');

% BPR function
rng(0);
alpha = 0.15;
beta = 4;
gamma = 0.5;
cap = 275*(mean(FreeFlowTime)./FreeFlowTime + gamma*(rand(size(FreeFlowTime))-0.5));

%% Bilevel optimization
maxIt = 100;
epsl = 1e-5;
prevFlows = zeros(size(FreeFlowTime));
filter_pole = 0.5;
tt = 100;
tt_prev = 0;

for k = 1:maxIt
    % Recompute travel times
    if k ~= 1
        load(strcat(city,'/Flows.mat'),'Flows');
        FlowTime = filter_pole*FlowTime + (1-filter_pole)*FreeFlowTime.*(1 + alpha*(Flows./cap).^beta);
        save(strcat(city,'/FlowTime.mat'),'FlowTime');
    end
    
    % Recompute flows
    recomputeFlows();



    % Check stopping criterion
    load(strcat(city,'/Flows.mat'),'Flows');

%     if k == 10, return; end
    error = max(abs((Flows-prevFlows)./Flows));
    prevFlows = Flows;
    tt = sum(Flows);
    fprintf("Iteration: %04d\t| rel. error: %g\t| sum flow: %g \n",k,error,tt);
    if  error < epsl
        fprintf("Stopping iterations: minimum improvement reached.\n");
        break;
    end
    if k == maxIt
        fprintf("Maximum number of iterations reached.\n");
    end
end

return;


%% Clear auxiliary .mat files
delete(strcat(city,'/FreeFlowTime.mat'));
delete(strcat(city,'/FlowTime.mat'));
delete(strcat(city,'/solPart_',city,'.mat'));
delete(strcat(city,'/MatL2.mat'));
rmdir(strcat(city,'/L2'),'s');
rmdir(strcat(city,'/Results'),'s');


%% %% Compute flow solution
% For an updated flow time in 'FlowTime.mat'
% Saves new flows 'Flows.mat'
function recomputeFlows()
    clear; A1_SP;
    clear; A2_LinearComb2_part1_NYC;
    clear; A2_LinearComb2_part2_NYC;
    clear; A3_Main_NYC_fullSol;
    clear;
end
