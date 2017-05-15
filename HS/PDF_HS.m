
function [ P ] = PDF_HS( HM)
%function [ P ] = PDF_PSO( pop,GlobalBest)
%% PSO Parameters

global VarMin VarMax
global nVar
global FW

HMS=size(HM,1);         % Harmony Memory Size
nNew=0.8*HMS;        % Number of New Harmonies
HMCR=0.9;       % Harmony Memory Consideration Rate
PAR=0.1;        % Pitch Adjustment Rate

VarSize=[1 nVar];

%% PSO Main Loop
Sample =[];
for k=1:10
    
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

        Sample = [Sample,NEW(k).Position];
    end
end
P=PDF_Cal(Sample);
end

