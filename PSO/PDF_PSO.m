function [ P ] = PDF_PSO( pop)
%function [ P ] = PDF_PSO( pop,GlobalBest)
%% PSO Parameters

global VarMin VarMax
global GlobalBest
global nVar
global w  

c1=1.5;         % Personal Learning Coefficient
c2=2.0;         % Global Learning Coefficient
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;
nPop=size(pop,1);
VarSize=[1 nVar];

%% PSO Main Loop
Sample =[];
for k=1:10
    
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
        
        Sample = [Sample,pop(i).Position];
    end
end
P=PDF_Cal(Sample);
end

