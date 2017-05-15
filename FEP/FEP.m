function [ pop ] = FEP( pop,fnum,iter)
%function [ pop ] = FEP( pop,fnum )
%% Problem Definition
global fhd
global nVar nFE
global VarMin VarMax

VarSize=[1 nVar];
%% Parameter for FEP
nPop = size(pop,1);
Tao=1/(sqrt(2*sqrt(nVar)));
Tao_=1/(sqrt(2*nVar));
qPop=nPop*0.1;   %The number of opponents
popf=pop;
%% Main Loop 
for i=1:nPop
    %         Delta = tan(pi*(rand(VarSize)-0.5));
    Delta = randn(VarSize);
    popf(i).Best.Position=pop(i).Best.Position+pop(i).Eta.*Delta;
    
    popf(i).Best.Position = max(popf(i).Best.Position,VarMin);
    popf(i).Best.Position = min(popf(i).Best.Position,VarMax);
    
    popf(i).Eta=pop(i).Eta.*(exp(Tao_*randn()+Tao*randn(VarSize)));
    
    popf(i).Cost=feval(fhd,popf(i).Best.Position,1,fnum);
    nFE=nFE+1;
end

%Combine Offspring and Parents
popc = [pop 
        popf];
[popc(1:end).Score]=deal(0);
%Pairwise Comparison
for i=1:2*nPop
    A=randperm(2*nPop);
    for j=1:qPop
        if popc(i).Cost<=popc(A(j)).Cost
            popc(i).Score = popc(i).Score+1;
        end
    end
end
%Sort Population
Score=[popc.Score];
[~,ScoreOrder]=sort(Score,'descend');
popc=popc(ScoreOrder);

pop=rmfield(popc,'Score');
%Truncation
pop=pop(1:nPop);

Costs=[pop.Cost];
[~, SortOrder]=sort(Costs);
pop=pop(SortOrder);


end

