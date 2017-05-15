function [ P ] = PDF_DE( pop )
%function [ P ] = PDF_DE( pop )
%%
global VarMin VarMax
global nVar
%%

beta_min=0.2;   % Lower Bound of Scaling Factor
beta_max=0.8;   % Upper Bound of Scaling Factor

pCR=0.9;        % Crossover Probability
nPop=size(pop,1);
VarSize=[1 nVar]; 
%% DE Sample Loop
Sample=[];
for k=1:10
    
    for i=1:nPop
        
        x=pop(i).Position;
        
        A=randperm(nPop);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Mutation
        %beta=unifrnd(beta_min,beta_max);
        beta=unifrnd(beta_min,beta_max,VarSize);
        y=pop(a).Position+beta.*(pop(b).Position-pop(c).Position);
        
        Bound = find(y>VarMax);
        y(Bound)=VarMax-mod(y(Bound)-VarMax,VarMax-VarMin);
        Bound = find(y<VarMin);
        y(Bound)=VarMin+mod(VarMin-y(Bound),VarMax-VarMin);
		
        % Crossover
        z=zeros(size(x));
        j0=randi([1 numel(x)]);
        for j=1:numel(x)
            if j==j0 || rand<=pCR
                z(j)=y(j);
            else
                z(j)=x(j);
            end
        end   
        Sample=[Sample z];
    end  
    
end
P = PDF_Cal(Sample);

end

