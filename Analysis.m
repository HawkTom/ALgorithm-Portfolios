clear;clc
%% Frideman test
load data_run.mat
RankMean =[];
MeanRank =[];
pp=[];cd=[];
for i=1:25
    [p, nemenyi, meanrank, CDa, rankmean] = nemenyi(E{i}, 1)
    RankMean = [RankMean;rankmean];
    MeanRank = [MeanRank;meanrank];
    pp=[pp p];
    cd = [cd CDa(2)];
    clear p nemenyi  meanrank  CDa  rankmean;
end
r=mean(RankMean);
m=mean(MeanRank);
P=mean(pp);
%% Worst Middle Best
load data_algorithm.mat
Worst = [];
Best = [];
Middle = [];
for i=1:15
    Worst  = [Worst max(C{i},[],2)];
    Best = [Best min(C{i},[],2)];
    Middle = [Middle median(C{i},2)];
end
