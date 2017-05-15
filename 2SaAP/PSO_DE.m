clear;
addpath(genpath(pwd));
global fhd fnum fidMain
global nVar FEs FunStr
global VarMin VarMax
global GlobalBest
%% Problem Option
fhd=str2func(FunStr);
fprintf(fidMain,'Function Number:%d\t',fnum);
[VarMax,VarMin,nVar]=Bounds(fnum,FunStr);
nPop=100;       % Population Size
MaxIt=300;     % Maximum Number of Iterations
VarSize=[1 nVar];   % Decision Variables Matrix Size
nFE=0;
TestIter=50; Al_str={'DE ','PSO '};
%% ALgorithm Initial
Pop=Init(nPop,fnum);
GlobalBest=Pop(1);
BestFormer = GlobalBest;
BestCost=zeros(MaxIt,1);
%% Test Iteration
P.DE = Pop;
P.PSO = Pop;
for k=1:TestIter
    P.DE = DE(P.DE,fnum);
    BestSol.DE = P.DE(1);
    [P.PSO,GlobalBest] = PSO(P.PSO,fnum,GlobalBest,k);
    BestSol.PSO = P.PSO(1);
    BestCost(k) = min([BestSol.DE.Cost BestSol.PSO.Cost]);
    nFE =nFE+2*nPop;
end
CostDecrease = abs([BestFormer.Cost-BestSol.DE.Cost BestFormer.Cost-BestSol.PSO.Cost]/BestFormer.Cost);
[~,AlFlag] = max(CostDecrease);
if AlFlag==1
    Pop = P.DE;
else
    Pop = P.PSO;
end
GlobalBest = Pop(1);
BestFormer = GlobalBest;
%% Main Loop
while nFE<FEs
    k=k+1;
    %% Evolution By The Selected Algorithm
    if AlFlag==1
        Pop = DE(Pop,fnum);
        nFE =nFE+nPop;
        if Pop(1).Cost < GlobalBest.Cost
            GlobalBest = Pop(1);
        end
    end
    if AlFlag==2
        [Pop,GlobalBest] = PSO(Pop,fnum,GlobalBest,k);
        nFE =nFE+nPop;
    end
    
    %% Update Personal Best and Global Best
    for i=1:nPop
        if Pop(i).Cost<Pop(i).Best.Cost            
            Pop(i).Best.Position=Pop(i).Position;
            Pop(i).Best.Cost=Pop(i).Cost;           
        end
    end
    
    %% Select Algorithm for Next Several Iteration 
    if mod(k,10)==0
        if AlFlag==1
             CostDecrease(1) = abs((BestFormer.Cost-GlobalBest.Cost)/BestFormer.Cost);
             if CostDecrease(1) <= 0
                 CostDecrease(1)=0;
             end
        else
            CostDecrease(2) = abs((BestFormer.Cost-GlobalBest.Cost)/BestFormer.Cost);
            if CostDecrease(2) <= 0
                CostDecrease(2)=0;
            end
        end
        BestFormer = GlobalBest;
        if CostDecrease == [0 0]
            AlFlag = randi(2);
        else
            [~,AlFlag] = max(CostDecrease);
        end
%         disp([Al_str{AlFlag} 'is choosen']);
    end
    disp(['nFE= ' num2str(nFE) ': Best Cost = ' num2str(GlobalBest.Cost)]);
    
    BestCost(k) = GlobalBest.Cost;
end
disp(['Best Cost = ' num2str( GlobalBest.Cost)]);
fprintf(fidMain,'The Best fitness is %.16f\n',GlobalBest.Cost-FBias(fnum,FunStr));
BestCost = BestCost - FBias(fnum,FunStr);
if fnum==8 || fnum==9
 plot(BestCost,'LineWidth',2,'Color',ColorS(8));
else
 semilogy(BestCost,'LineWidth',2,'Color',ColorS(8));
end
xlabel('Iteration');
ylabel('Cost');
grid on;
hold on;