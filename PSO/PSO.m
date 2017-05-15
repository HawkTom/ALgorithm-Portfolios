function [ pop,GlobalBest ] = PSO( pop,fnum,GlobalBest,iter)
%[ pop,GlobalBest ] = PSO( pop,fnum,GlobalBest,iter)
%% PSO Parameters

global w
global VarMin VarMax
global fhd
global nVar nFE


wdamp=0.99;     % Inertia Weight Damping Ratio
c1=1.5;         % Personal Learning Coefficient
c2=2.0;         % Global Learning Coefficient
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;
nPop=size(pop,1);
VarSize=[1 nVar];
w=0.99^iter;
%% PSO Main Loop

    for i=1:nPop
        
        % Update Velocity
        pop(i).Velocity = w*pop(i).Velocity ...
            +c1*rand(VarSize).*(pop(i).Best.Position-pop(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-pop(i).Position);
        
        % Apply Velocity Limits
        pop(i).Velocity = max(pop(i).Velocity,VelMin);
        pop(i).Velocity = min(pop(i).Velocity,VelMax);
        
        % Update Position
        pop(i).Position = pop(i).Position + pop(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside=(pop(i).Position<VarMin | pop(i).Position>VarMax);
        pop(i).Velocity(IsOutside)=-pop(i).Velocity(IsOutside);
        
        % Apply Position Limits
        pop(i).Position = max(pop(i).Position,VarMin);
        pop(i).Position = min(pop(i).Position,VarMax);
        
        % Evaluation
        pop(i).Cost = feval(fhd,pop(i).Position,1,fnum);
        nFE=nFE+1;
        % Update Personal Best
        if pop(i).Cost<pop(i).Best.Cost
            
            pop(i).Best.Position=pop(i).Position;
            pop(i).Best.Cost=pop(i).Cost;
            
            % Update Global Best
            if pop(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=pop(i).Best;
                
            end
            
        end
        
    end
    Costs=[pop.Cost];
    [~, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
%     BestCost=min([pop.Cost]);
%     
%     % Show Iteration Information
%     disp([': Best Cost = ' num2str(BestCost)]);  
%     w=w*wdamp;





end

