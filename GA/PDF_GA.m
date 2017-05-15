function [ P ] = PDF_GA( pop )
global VarMin VarMax
%function [ P ] = PDF_GA( pop )
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
for i=1:10
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
    
end

% Create Merged Population
Sample=[popc 
        popm];
Sample=[Sample.Position];
end

P=PDF_Cal(Sample);


end

