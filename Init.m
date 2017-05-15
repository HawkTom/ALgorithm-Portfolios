function [ pop] = Init( nPop,fnum)
%% Global  Defintion
global fhd
global nVar nFE
global VarMin VarMax
global w FW

empty_individual.Position=[];
empty_individual.Cost=[];
VarSize=[1 nVar]; 

%% Population Initial

pop=repmat(empty_individual,nPop,1);
for i=1:nPop
    
    % Initialize Position
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    % Evaluation
    pop(i).Cost=feval(fhd,pop(i).Position,1,fnum);
    % Velocity for PSO
    pop(i).Velocity=zeros(VarSize);
    % Personal Best 
    pop(i).Best.Position=pop(i).Position;
    pop(i).Best.Cost=pop(i).Cost;
end
nFE=nFE+nPop;
% Sort Population
Costs=[pop.Cost];
[~, SortOrder]=sort(Costs);
pop=pop(SortOrder);
%% Inertia Weight In PSO 
 w=1; FW=0.02*(VarMax-VarMin);    % Fret Width (Bandwidth)
end

