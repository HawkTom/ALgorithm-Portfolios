close all
clear;clc;
format long
addpath(genpath(pwd));
rng(sum(100*clock));
global fidDE fidPSO fidGA fidMain fidHM
global fnum FEs FunStr
FEs=100000;
FunStr = 'benchmark';
fidDE = fopen('Result/Result_DE.xls','wt');
fidPSO = fopen('Result/Result_PSO.xls','wt');
fidHM = fopen('Result/Result_HM.xls','wt');
fidGA = fopen('Result/Result_GA.xls','wt');
fidMain = fopen('Result/Result_Main.xls','wt');
for RunTime=1:1
    save RunTime.mat RunTime
    fprintf(fidMain,'RunTime %d \n',RunTime);
    for fnum=13:13
%         pso_demo;
        ga_demo;
%         HS_demo;
        de_demo;
%         HS_DE;
%         HS_GA;
        GA_DE;
%         PSO_DE;
%         PSO_GA;
%         main;
%         GA_PSO_DE;
%         HS_GA_DE;
%         HS_GA_PSO;
%         HS_PSO_DE;
%         HS_PSO_DE_GA;
%         legend('PSO','GA','HS','DE','HS DE','HS GA','GA DE','PSO DE','PSO GA','PSO HS','GA PSO DE','HS GA DE','HS GA PSO','HS PSO DE','HS PSO DE GA');
        legend('GA','DE','GA DE');
        title(['Function ' num2str(fnum)]);
        set(gcf,'PaperUnits','inches','PaperPosition',[0 0 14 10])
        load RunTime.mat;
        imgName = strcat('Result/',num2str(fnum),'.jpg');
        saveas(gcf,imgName)
        close all;
    end
    fprintf(fidMain,'\n');
end