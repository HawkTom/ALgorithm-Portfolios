%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA101
% Project Title: Implementation of Real-Coded Genetic Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
%
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
clear;
format long
global fnum fidGA FEs FunStr
%% Run for 8 times

Best=[];
fhd=str2func(FunStr);
fprintf(fidGA,'Function Number:%d\t',fnum);
    for run=1:1
        %% Problem Definition                
        
        Fun=1:23;
        [VarMax,VarMin,nVar]=Bounds(Fun(fnum),FunStr);% Upper and Lower Bound of Variables  % Number of Decision Variables
        VarSize=[1 nVar];   % Decision Variables Matrix Size
        nFE=0;
        %% GA Parameters
        
        MaxIt=10;     % Maximum Number of Iterations
        
        nPop=100;       % Population Size
        
        pc=0.7;                 % Crossover Percentage
        nc=2*round(pc*nPop/2);  % Number of Offsprings (also Parnets)
        gamma=0.4;              % Extra Range Factor for Crossover
        
        pm=0.3;                 % Mutation Percentage
        nm=round(pm*nPop);      % Number of Mutants
        mu=0.1;         % Mutation Rate
        
      
        %% Initialization
        
        empty_individual.Position=[];
        empty_individual.Cost=[];
        
        pop=repmat(empty_individual,nPop,1);
        for i=1:nPop
            
            % Initialize Position
            pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
            % Evaluation
            pop(i).Cost=fhd(pop(i).Position,1,Fun(fnum));
             nFE=nFE+1;
        end
        
        % Sort Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs);
        pop=pop(SortOrder);
        
        % Store Best Solution
        BestSol=pop(1);
        Best=BestSol.Position;
        % Array to Hold Best Cost Values
        BestCost=zeros(MaxIt,1);
        
        % Store Cost
        WorstCost=pop(end).Cost;
        
        %% Main Loop
        it=0;
       while nFE<FEs;
            it=it+1;
            
            % Crossover
            popc=repmat(empty_individual,nc/2,2);
            for k=1:nc/2
                
                    i1=randi([1 nPop]);
                    i2=randi([1 nPop]);
                
                % Select Parents
                p1=pop(i1);
                p2=pop(i2);
                
                % Apply Crossover
                [popc(k,1).Position, popc(k,2).Position]=Crossover(p1.Position,p2.Position,gamma,VarMax,VarMin);
                
                % Evaluate Offsprings
                popc(k,1).Cost=fhd(popc(k,1).Position,1,Fun(fnum));
                popc(k,2).Cost=fhd(popc(k,2).Position,1,Fun(fnum));
                 nFE=nFE+2;
            end
            popc=popc(:);
            
            
            % Mutation
            popm=repmat(empty_individual,nm,1);
            for k=1:nm
                
                % Select Parent
                i=randi([1 nPop]);
                p=pop(i);
                
                % Apply Mutation
                popm(k).Position=Mutate(p.Position,mu,VarMax,VarMin);
                
                % Evaluate Mutant
                popm(k).Cost=fhd(popm(k).Position,1,Fun(fnum));
                 nFE=nFE+1;
            end
            
            % Create Merged Population
            pop=[pop
                popc
                popm]; %#ok

            
            
            % Sort Population
            Costs=[pop.Cost];
            [Costs, SortOrder]=sort(Costs);
            pop=pop(SortOrder);
            
            % Update Worst Cost
            WorstCost=max(WorstCost,pop(end).Cost);
            
            % Truncation
            pop=pop(1:nPop);
            Costs=Costs(1:nPop);
            
            % Store Best Solution Ever Found
            BestSol=pop(1);
            Best = [Best;BestSol.Position];
            % Store Best Cost Ever Found
            BestCost(it)=BestSol.Cost;
            
            % Show Iteration Information
            
            disp(['Iteration ' num2str(nFE) ': Best Cost = ' num2str(pop(1).Cost)]);
        end
        disp([ ' Best Cost = ' num2str(pop(1).Cost)]);
        fprintf(fidGA,'The Best fitness is %.16f\n',pop(1).Cost-FBias(fnum,FunStr));
    end

%% Results

BestCost = BestCost - FBias(fnum,FunStr);

if fnum==8 || fnum==9
 plot(BestCost,'LineWidth',2,'Color',ColorS(2));
else
 semilogy(BestCost,'LineWidth',2,'Color',ColorS(2));
end

xlabel('Iteration');
ylabel('Cost');
grid on;
hold on