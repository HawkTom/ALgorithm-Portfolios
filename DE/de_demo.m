%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA107
% Project Title: Implementation of Differential Evolution (DE) in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
%
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clear;format long
global fnum fidDE FEs FunStr
%% Run for 8 times
fhd=str2func(FunStr);
fprintf(fidDE,'Function Number:%d\t',fnum);
for run=1:1
    %% Problem Definition
    BestCost=zeros(10,1);
    CostFunction=@(x,i,f) fhd(x,i,f);        % Cost Function
    Fun=1:23;
    [VarMax,VarMin,nVar]=Bounds(Fun(fnum),FunStr);% Upper and Lower Bound of Variables  % Number of Decision Variables
    VarSize=[1 nVar];   % Size of Decision Variables Matrix
    %% DE Parameters
    
    MaxIt=10;      % Maximum Number of Iterations
    nFE=0;
    nPop=100;        % Population Size
    
    beta_min=0.2;   % Lower Bound of Scaling Factor
    beta_max=0.8;   % Upper Bound of Scaling Factor
    
    pCR=0.9;        % Crossover Probability
    
    %% Initialization
    
    empty_individual.Position=[];
    empty_individual.Cost=[];
    
    BestSol.Cost=inf;
    
    pop=repmat(empty_individual,nPop,1);
    for i=1:nPop
        
        pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
        pop(i).Cost=CostFunction(pop(i).Position,1,Fun(fnum));
        nFE=nFE+1;
        if pop(i).Cost<BestSol.Cost
            BestSol=pop(i);
        end
        
    end
    
    BestCost=zeros(MaxIt,1);
    Best=BestSol.Position;
    %% DE Main Loop
    it=0;MutationSol=[];
    while nFE<FEs
        it=it+1;
        for i=1:nPop
            
            x=pop(i).Position;
            
            A=randperm(nPop);
            
            A(A==i)=[];
            
            a=A(1);
            b=A(2);
            c=A(3);
            
            % Mutation
            %beta=unifrnd(beta_min,beta_max);
            beta=unifrnd(beta_min,beta_max,VarSize);
            y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
            y = max(y, VarMin);
            y = min(y, VarMax);
            
            % Crossover
            z=zeros(size(x));
            j0=randi([1 numel(x)]);
            for j=1:numel(x)
                if j==j0 || rand<=pCR
                    z(j)=y(j);
                else
                    z(j)=x(j);
                end
            end
           
            NewSol.Position=z;
            NewSol.Cost=CostFunction(NewSol.Position,1,Fun(fnum));
            nFE=nFE+1;
            if NewSol.Cost<pop(i).Cost
                pop(i)=NewSol;
                
                if pop(i).Cost<BestSol.Cost
                    BestSol=pop(i);
                end
            end
            
        end
        
        % Update Best Cost
        BestCost(it)=BestSol.Cost;
        Best = [Best;BestSol.Position];
        % Show Iteration Information
%         disp(['Iteration ' num2str(nFE) ': Best Cost = ' num2str(BestSol.Cost)]);
        
    end
    disp([ ' Best Cost = ' num2str(BestSol.Cost)]);
    fprintf(fidDE,'The Best fitness is %.16f\n',BestSol.Cost - FBias(fnum,FunStr));
end
%% Show Results

BestCost = BestCost - FBias(fnum,FunStr);
%plot(BestCost);
if fnum==8 || fnum==9
    plot(BestCost,'LineWidth',2,'Color',ColorS(1));
else
    semilogy(BestCost,'LineWidth',2,'Color',ColorS(1));
end
xlabel('Iteration');
ylabel('Best Cost');
grid on;
