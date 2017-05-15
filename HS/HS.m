function [HM] = HS( HM,fnum,iter)
%function [HM] = HS( HM,fnum,iter)
%% PSO Parameters
global FW
global VarMin VarMax
global fhd
global nVar nFE


HMS=size(HM,1);         % Harmony Memory Size
nNew=0.8*HMS;        % Number of New Harmonies
HMCR=0.9;       % Harmony Memory Consideration Rate
PAR=0.1;        % Pitch Adjustment Rate

FW_damp=0.995;              % Fret Width Damp Ratio
FW=FW_damp^iter;
VarSize=[1 nVar];
%% Harmony Search Main Loop

    
%     % Initialize Array for New Harmonies
%     NEW=HM;
    NEW=HM(1:nNew);
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
        NEW(k).Cost=feval(fhd,NEW(k).Position,1,fnum);
        nFE = nFE+1;
    end
    % Merge Harmony Memory and New Harmonies
    HM=[HM
        NEW]; 
    
    % Sort Harmony Memory
    [~, SortOrder]=sort([HM.Cost]);
    HM=HM(SortOrder);
    
    % Truncate Extra Harmonies
    HM=HM(1:HMS);
    





end

