clear;clc;
global fnum FEs
global fidDE fidPSO fidGA fidMain fidHM
addpath(genpath(pwd));
rng(sum(100*clock));
FEs=30000;
fnum=2;
fidDE = fopen('Result/Result_DE.xls','wt');
fidPSO = fopen('Result/Result_PSO.xls','wt');
fidHM = fopen('Result/Result_HM.xls','wt');
fidGA = fopen('Result/Result_GA.xls','wt');
fidMain = fopen('Result/Result_Main.xls','wt');

[VarMax,VarMin,nVar]=Bounds(fnum,'benchmark');
empty_individual.Position=[];
empty_individual.Cost=[];
VarSize=[1 nVar]; 
nPop = 100;
%% Population Initial

PopTest=repmat(empty_individual,nPop,1);
for i=1:nPop
    % Initialize Position
    PopTest(i).Position=unifrnd(VarMin,VarMax,VarSize);
    % Evaluation
    PopTest(i).Cost=benchmark(PopTest(i).Position,1,fnum);
end
save PopData.mat PopTest
for i=1:10
de_demo;
ga_demo;
HS_demo;
pso_demo;

AlgorithmSelectioncCal;
end