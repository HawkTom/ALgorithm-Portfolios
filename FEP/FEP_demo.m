
clear;
clc;
format long
global fnum fidFEP FEs
BestCost=zeros(10,1);
%% Run for 8 times

fprintf(fidFEP,'Function Number:%d\n',fnum);
for run=1:1
    %% Problem Definetion
    nPop=100;
    fhd=str2func('benchmark');
    Fun=1:23;
    [VarMax,VarMin,nVar]=Bounds(Fun(fnum),'benchmark');% Upper and Lower Bound of Variables  % Number of Decision Variables
    VarSize=[1 nVar];   % Decision Variables Matrix Size
    nFE=0;
    %%  Parameter for FEP
    Tao=1/(sqrt(2*sqrt(nVar)));
    Tao_=1/(sqrt(2*nVar));
    qPop=nPop*0.1;   %The number of opponents
    %%
    % pop=repmat(empty_individual,nPop,1);
    
    for i=1:nPop
        % Initialize Position
        pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
        % Evaluation
        pop(i).Cost=feval(fhd,pop(i).Position,1,Fun(fnum));
        % FEP Eta
        pop(i).Eta=3.0*ones(VarSize);
    end
    popf=pop;   %The offpring
    nFE=nFE+nPop;
    %% FEP Main Loop
    k=0;
    while nFE < FEs
        k=k+1;
        %mutation
        for i=1:nPop
            %         Delta = tan(pi*(rand(VarSize)-0.5));
            Delta = trnd(1,VarSize);
            popf(i).Position=pop(i).Position+pop(i).Eta.*Delta;
            
            popf(i).Position = max(popf(i).Position,VarMin);
            popf(i).Position = min(popf(i).Position,VarMax);
            
            popf(i).Eta=pop(i).Eta.*exp(Tao_*randn()+Tao*randn(VarSize));
            
            popf(i).Cost=feval(fhd,popf(i).Position,1,Fun(fnum));
            
        end
        nFE=nFE+nPop;
        %Combine Offspring and Parents
        popc = [pop;
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
        BestCost(k)=pop(1).Cost;
        disp(['Iteration ' num2str(nFE) ': Best Cost = ' num2str(pop(1).Cost)]);
    end
    disp(['Run ' num2str(run) ': Best Cost = ' num2str(pop(1).Cost)]);
    fprintf(fidFEP,'Run: %d\t',run);
    fprintf(fidFEP,'The Best fitness is %.16f\n',FBias(fnum)-pop(1).Cost);
end
fprintf(fidFEP,'\n');

BestCost = BestCost - FBias(fnum);
save FEP.mat BestCost;
semilogy(BestCost,'LineWidth',1,'Color','g');
% plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Cost');
grid on;
hold on
