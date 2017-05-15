function [ pop ] = GA( pop,fnum )
%function [ pop ] = GA( pop,fnum )
global fhd nFE
global VarMin VarMax
%% Problem Definition

nPop=size(pop,1);       % Population Size

pc=0.7;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (also Parnets)
gamma=0.4;              % Extra Range Factor for Crossover

pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants
mu=0.1;         % Mutation Rate

%% Main Loop
empty_individual.Position=[];
empty_individual.Cost=[];


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
    popc(k,1).Cost=feval(fhd,popc(k,1).Position,1,fnum);
    popc(k,2).Cost=feval(fhd,popc(k,2).Position,1,fnum);
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
    popm(k).Cost=feval(fhd,popm(k).Position,1,fnum);
    nFE=nFE+1;
end

% Create Merged Population
popTemp = rmfield(rmfield(pop,'Velocity'),'Best');
popTemp = [popTemp
           popc
           popm];

% Sort Population
Costs=[popTemp.Cost];
[~, SortOrder]=sort(Costs);
popTemp=popTemp(SortOrder);
% Truncation
popTemp=popTemp(1:nPop);
[pop(1:end).Cost] = deal(popTemp(1:end).Cost);
[pop(1:end).Position] = deal(popTemp(1:end).Position);

end

