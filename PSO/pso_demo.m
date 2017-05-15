%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA102
% Project Title: Implementation of Particle Swarm Optimization in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
%
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
clear;format long
global fnum fidPSO FEs FunStr
%% Run for 8 times
fhd=str2func(FunStr);
fprintf(fidPSO,'Function Number:%d\t',fnum);
for run=1:1
    %% PSO Parameters
    
    MaxIt=10;      % Maximum Number of Iterations
    
    nPop=100;        % Population Size (Swarm Size)
    
    % PSO Parameters
    w=1;            % Inertia Weight
    wdamp=0.99;     % Inertia Weight Damping Ratio
    c1=1.5;         % Personal Learning Coefficient
    c2=2.0;         % Global Learning Coefficient
    nFE=0;
    %% Initialization
    
    empty_particle.Position=[];
    empty_particle.Cost=[];
    empty_particle.Velocity=[];
    empty_particle.Best.Position=[];
    empty_particle.Best.Cost=[];
    
    particle=repmat(empty_particle,nPop,1);
    
    GlobalBest.Cost=inf;
    
    
    %% Problem Definition
    CostFunction=@(x,i,f) fhd(x,i,f);        % Cost Function
    Fun=1:23;
    [VarMax,VarMin,nVar]=Bounds(Fun(fnum),FunStr);% Upper and Lower Bound of Variables  % Number of Decision Variables
    VarSize=[1 nVar];   % Size of Decision Variables Matrix
    % Velocity Limits
    VelMax=0.1*(VarMax-VarMin);
    VelMin=-VelMax;
    
    %% Initialization
    for i=1:nPop
        % Initialize Position
        particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
        % Initialize Velocity
        particle(i).Velocity=zeros(VarSize);
        
        % Evaluation
        particle(i).Cost=CostFunction(particle(i).Position,1,Fun(fnum));
        nFE=nFE+1;
        % Update Personal Best
        particle(i).Best.Position=particle(i).Position;
        particle(i).Best.Cost=particle(i).Cost;
        
        % Update Global Best
        if particle(i).Best.Cost<GlobalBest.Cost
            
            GlobalBest=particle(i).Best;
            
        end
        
    end
    
    BestCost=zeros(MaxIt,1);
    Best=GlobalBest.Position;
    %% PSO Main Loop
    it=0;MutationSol=[];
    while nFE<FEs
        it=it+1;
        for i=1:nPop
            
            % Update Velocity
            particle(i).Velocity = w*particle(i).Velocity ...
                +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
                +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
            
            % Apply Velocity Limits
            particle(i).Velocity = max(particle(i).Velocity,VelMin);
            particle(i).Velocity = min(particle(i).Velocity,VelMax);
            
            % Update Position
            particle(i).Position = particle(i).Position + particle(i).Velocity;
            
            % Velocity Mirror Effect
            IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
            particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
            
            % Apply Position Limits
            particle(i).Position = max(particle(i).Position,VarMin);
            particle(i).Position = min(particle(i).Position,VarMax);
            
            % Evaluation
            particle(i).Cost = CostFunction(particle(i).Position,1,Fun(fnum));
            nFE=nFE+1;
            % Update Personal Best
            if particle(i).Cost<particle(i).Best.Cost
                
                particle(i).Best.Position=particle(i).Position;
                particle(i).Best.Cost=particle(i).Cost;
                
                % Update Global Best
                if particle(i).Best.Cost<GlobalBest.Cost
                    
                    GlobalBest=particle(i).Best;
                    
                end
                
            end
            
        end
        
        BestCost(it)=GlobalBest.Cost;

        Best = [Best;GlobalBest.Position];
        
        w=w*wdamp;
        disp(['Run = ' num2str(nFE) ' Function = ' num2str(Fun(fnum)) ' Best Cost = ' num2str(GlobalBest.Cost)]);
    end
    
    %         disp(['Iteration ' num2str() ': Best Cost = ' num2str(GlobalBest.Cost)]);
    %% Result Write to File
    fprintf(fidPSO,'The Best fitness is %.16f\n',GlobalBest.Cost-FBias(fnum,FunStr));
end

BestSol = GlobalBest;
%% Results
BestCost = BestCost - FBias(fnum,FunStr);
if fnum==8 || fnum==9
 plot(BestCost,'LineWidth',2,'Color',ColorS(4));
else
 semilogy(BestCost,'LineWidth',2,'Color',ColorS(4));
end
xlabel('Iteration');
ylabel('Best Cost');
grid on;
hold on;
