function [ P ] = PDF_FEP( pop )
%function [ P ] = PDF_FEP( pop )
%% Problem Definition
global nVar
global VarMin VarMax

VarSize=[1 nVar];
%% Parameter for FEP
nPop = size(pop,1);
Tao=1/(sqrt(2*sqrt(nVar)));
Tao_=1/(sqrt(2*nVar));
popf=pop;
%% Sample Loop 
Sampe=[];
for k=1:10
    for i=1:nPop
        %         Delta = tan(pi*(rand(VarSize)-0.5));
        Delta = trnd(1,VarSize);
        popf(i).Position=pop(i).Position+pop(i).Eta.*Delta;
        
        popf(i).Position = max(popf(i).Position,VarMin);
        popf(i).Position = min(popf(i).Position,VarMax);
        
        popf(i).Eta=pop(i).Eta.*exp(Tao_*randn()+Tao*randn(VarSize));
        Sampe = [Sampe popf(i).Position];
    end
    
end

P = PDF_Cal(Sampe);


end

