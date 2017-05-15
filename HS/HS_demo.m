%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA117
% Project Title: Implementation of Harmony Search in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

clear;
global fnum FEs fidHM FunStr

        %% Problem Definitionaa
        fhd=str2func(FunStr);
        CostFunction=@(x,i,f) fhd(x,i,f);        % Cost Function
        Fun=1:23;
        [VarMax,VarMin,nVar]=Bounds(Fun(fnum),FunStr);% Upper and Lower Bound of Variables  % Number of Decision Variables
        VarSize=[1 nVar];   % Decision Variables Matrix Size
        
        %% Harmony Search Parameters
        
        MaxIt=1000;     % Maximum Number of Iterations
        HMS=100;         % Harmony Memory Size
        nNew=100;        % Number of New Harmonies
        HMCR=0.9;       % Harmony Memory Consideration Rate
        PAR=0.1;        % Pitch Adjustment Rate
        FW=0.02*(VarMax-VarMin);    % Fret Width (Bandwidth)
        FW_damp=0.995;              % Fret Width Damp Ratio
        
        
        %% Initialization
        nFE=0;
        % Empty Harmony Structure
        empty_harmony.Position=[];
        empty_harmony.Cost=[];
        
        % Initialize Harmony Memory
        HM=repmat(empty_harmony,HMS,1);
        % Create Initial Harmonies
        for i=1:HMS
            HM(i).Position=unifrnd(VarMin,VarMax,VarSize);
            HM(i).Cost=CostFunction(HM(i).Position,1,Fun(fnum));
            nFE = nFE+1;
        end
        
        % Sort Harmony Memory
        [~, SortOrder]=sort([HM.Cost]);
        HM=HM(SortOrder);
        
        % Update Best Solution Ever Found
        BestSol=HM(1);
        Best=BestSol.Position;
        % Array to Hold Best Cost Values
        BestCost=zeros(MaxIt,1);
        it =0 ;
        %% Harmony Search Main Loop
        
        while nFE<FEs
            it=it+1;
            % Initialize Array for New Harmonies
            NEW=repmat(empty_harmony,nNew,1);
            
            % Create New Harmonies
            for k=1:nNew
                
                % Create New Harmony Position
                NEW(k).Position=unifrnd(VarMin,VarMax,VarSize);
                for j=1:nVar
                    if rand<=HMCR
                        % Use Harmony Memory
                        i=randi([1 HMS]);
                        NEW(k).Position(j)=HM(i).Position(j);
                    end
                    
                    % Pitch Adjustment
                    if rand<=PAR
                        %DELTA=FW*unifrnd(-1,+1);    % Uniform
                        DELTA=FW*randn();            % Gaussian (Normal)
                        NEW(k).Position(j)=NEW(k).Position(j)+DELTA;
                    end
                    
                end
                
                % Apply Variable Limits
                NEW(k).Position=max(NEW(k).Position,VarMin);
                NEW(k).Position=min(NEW(k).Position,VarMax);
                
                % Evaluation
                NEW(k).Cost=CostFunction(NEW(k).Position,1,Fun(fnum));
                nFE = nFE+1;
                
            end
            
            % Merge Harmony Memory and New Harmonies
            HM=[HM
                NEW]; %#ok

            % Sort Harmony Memory
            [~, SortOrder]=sort([HM.Cost]);
            HM=HM(SortOrder);
            
            % Truncate Extra Harmonies
            HM=HM(1:HMS);
            
            % Update Best Solution Ever Found
            BestSol=HM(1);
            Best = [Best;BestSol.Position];
            % Store Best Cost Ever Found
            BestCost(it)=BestSol.Cost;
            
            % Show Iteration Information
            disp(['Iteration ' num2str(nFE) ': Best Cost = ' num2str(BestCost(it))]);
            
            % Damp Fret Width
            FW=FW*FW_damp;
            
        end
%         fprintf(fidHM,'Run: %d\t ',run);  
        fprintf(fidHM,'fnum = %d\t',Fun(fnum));
        fprintf(fidHM,'The Best fitness is %.16f\n',BestSol.Cost - FBias(fnum,FunStr));
%% Results
if fnum==8 || fnum==9
 plot(BestCost,'LineWidth',2,'Color',ColorS(3));
else
 semilogy(BestCost,'LineWidth',2,'Color',ColorS(3));
end
xlabel('Iteration');
ylabel('Best Cost');
grid on;
hold on;