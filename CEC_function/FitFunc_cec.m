function [ fit_r ] = FitFunc_cec(x,u,func_num)
global initial_flag
persistent fhd f_bias
fit_r=zeros(1,u);
% benchmark_func.m is the main function for 25 test functions, all minimize
% problems
% e.g. f=benchmark_func(x,func_num)
% x is the variable, f is the function value 
% func_num is the function num,

%       25 TEST FUCNTIONS
% 	    Unimodal Functions (5):
% 1.    Shifted Sphere Function 					                Bounds[-100,100]	f_bias=-450
% 2.	Shifted Schwefel's Problem 1.2				            	Bounds[-100,100]	f_bias=-450
% 3.	Shifted Rotated High Conditioned Elliptic Function			Bounds[-100,100]	f_bias=-450
% 4.	Shifted Schwefel's Problem 1.2 with Noise in Fitness 		Bounds[-100,100]	f_bias=-450
% 5.	Schwefel's  Problem 2.6 with Global Optimum on Bounds		Bounds[-100,100]	f_bias=-310
% 
% 	    Multimodal Functions (20):
% 	    Basic Functions (7):
% 6.	Shifted Rosenbrock's  Function					            Bounds[-100,100]	f_bias=390 
% 7.	Shifted Rotated Griewank's  Function without Bounds	        Initilization Range [0, 600]	f_bias=-180
% 8.	Shifted Rotated Ackley's  Function with Global Optimum on Bounds	Bounds[-32,32]	f_bias=-140
% 9.	Shifted Rastrigin's  Function 					            Bounds[-5,5]	    f_bias=-330
% 10.	Shifted Rotated Rastrigin's  Function 				        Bounds[-5,5]	    f_bias=-330
% 11.	Shifted Rotated Weierstrass Function 				        Bounds[-0.5,0.5]	f_bias=90
% 12.	Schwefel's  Problem 2.13					                Bounds[-100,100]	f_bias=-460 
% 	    Expanded Functions (2):
% 13.	Expanded Extended Griewank's  plus Rosenbrock's  Function (F8F2)	Bounds[-3,1]	f_bias=-130
% 14.	Expanded Rotated Extended Scaffe's  F6 				        Bounds[-100,100]	f_bias=-300


if func_num==1 fhd=str2func('sphere_func'); %[-100,100]
elseif func_num==2 fhd=str2func('schwefel_102'); %[-100,100]
elseif func_num==3 fhd=str2func('high_cond_elliptic_rot_func'); %[-100,100]
elseif func_num==4 fhd=str2func('schwefel_102_noise_func'); %[-100,100]
elseif func_num==5 fhd=str2func('schwefel_206'); %[no bound],initial[-100,100];
elseif func_num==6 fhd=str2func('rosenbrock_func'); %[-100,100]
elseif func_num==7 fhd=str2func('griewank_rot_func'); %[-600,600]
elseif func_num==8 fhd=str2func('ackley_rot_func'); %[-32,32]
elseif func_num==9 fhd=str2func('rastrigin_func'); %[-5,5]
elseif func_num==10 fhd=str2func('rastrigin_rot_func'); %[-5,5]
elseif func_num==11 fhd=str2func('weierstrass_rot'); %[-0.5,0.5]
elseif func_num==12 fhd=str2func('schwefel_213'); %[-pi,pi]
elseif func_num==13 fhd=str2func('EF8F2_func'); %[-3,1] 
elseif func_num==14 fhd=str2func('E_ScafferF6_func'); %[-100,100]
end
load fbias_data;
initial_flag = 0;
for i=1:u
    fit_r(i)=feval(fhd,x(i,:))+f_bias(func_num);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%Unimodal%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	1.Shifted Sphere Function 
function fit=sphere_func(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load sphere_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-100+200*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
fit=sum(x.^2,2);

% 	2.Shifted Schwefel's Problem 1.2
function f=schwefel_102(x)
global initial_flag
persistent o
[ps,D]=size(x);
if initial_flag==0
    load schwefel_102_data
   if length(o)>=D
         o=o(1:D);
    else
         o=-100+200*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end

% 	3.Shifted Rotated High Conditioned Elliptic Function
function fit=high_cond_elliptic_rot_func(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load high_cond_elliptic_rot_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-100+200*rand(1,D);
    end
    c=1;
    if D==2,load elliptic_M_D2,
    elseif D==10,load elliptic_M_D10,
    elseif D==30,load elliptic_M_D30,
    elseif D==50,load elliptic_M_D50,
    else 
        A=normrnd(0,1,D,D);[M,r]=cGram_Schmidt(A);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
x=x*M;
a=1e+6;
fit=0;
for i=1:D
fit=fit+a.^((i-1)/(D-1)).*x(:,i).^2;
end

% 	4.Shifted Schwefel's Problem 1.2 with Noise in Fitness 
function f=schwefel_102_noise_func(x)
global initial_flag
persistent o
[ps,D]=size(x);
if initial_flag==0
    load schwefel_102_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-100+200*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
f=f.*(1+0.4.*abs(normrnd(0,1,ps,1)));

% 	5.Schwefel's Problem 2.6
function f=schwefel_206(x)%after Fletcher and Powell
global initial_flag
persistent A B o
[ps,D]=size(x);
if initial_flag==0
    initial_flag=1;
    load schwefel_206_data
    if length(o)>=D
         A=A(1:D,1:D);o=o(1:D);
    else
         o=-100+200*rand(1,D);
         A=round(-100+2*100.*rand(D,D));
         while det(A)==0
         A=round(-100+2*100.*rand(D,D));
         end
    end
    o(1:ceil(D/4))=-100;o(max(floor(0.75*D),1):D)=100;
    B=A*o';
end
for i=1:ps
f(i,1)=max(abs(A*(x(i,:)')-B));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%Multimodal%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 	6.Shifted Rosenbrock's Function
function f=rosenbrock_func(x)
global initial_flag
persistent o
[ps,D]=size(x);
if initial_flag==0
    load rosenbrock_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-90+180*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1)+1;
f=sum(100.*(x(:,1:D-1).^2-x(:,2:D)).^2+(x(:,1:D-1)-1).^2,2);

% 	7.Shifted Rotated Griewank's Function
function f=griewank_rot_func(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load griewank_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-600+0*rand(1,D);
    end
    c=3;
    if D==2,load griewank_M_D2,,
    elseif D==10,load griewank_M_D10,
    elseif D==30,load griewank_M_D30,
    elseif D==50,load griewank_M_D50,
    else 
        M=rot_matrix(D,c);
        M=M.*(1+0.3.*normrnd(0,1,D,D));
    end
    o=o(1:D);
    initial_flag=1;
end
x=x-repmat(o,ps,1);
x=x*M;
f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
f=sum(x.^2,2)./4000-f+1;

% 	8.Shifted Rotated Ackley's Function with Global Optimum on Bounds
function f=ackley_rot_func(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load ackley_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-30+60*rand(1,D);
    end
    o(2.*[1:floor(D/2)]-1)=-32;
    c=100;
    if D==2,load ackley_M_D2,,
    elseif D==10,load ackley_M_D10,
    elseif D==30,load ackley_M_D30,
    elseif D==50,load ackley_M_D50,
    else 
       M=rot_matrix(D,c);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
x=x*M;
f=sum(x.^2,2);
f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);

% 	9.Shifted Rastrign's Function
function f=rastrigin_func(x)
global initial_flag
persistent o
[ps,D]=size(x);
if initial_flag==0
    load rastrigin_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-5+10*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);

% 	10.Shifted Rotated Rastrign's Function 
function f=rastrigin_rot_func(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load rastrigin_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-5+10*rand(1,D);
    end
    c=2;
    if D==2,load rastrigin_M_D2,,
    elseif D==10,load rastrigin_M_D10,
    elseif D==30,load rastrigin_M_D30,
    elseif D==50,load rastrigin_M_D50,
    else 
        M=rot_matrix(D,c);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
x=x*M;
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);

% 	11.Shifted Rotated Weierstrass Function
function [f]=weierstrass_rot(x)
global initial_flag
persistent o M
[ps,D]=size(x);
if initial_flag==0
    load weierstrass_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-0.5+0.5*rand(1,D);
    end
    c=5;
    if D==2,load weierstrass_M_D2,,
    elseif D==10,load weierstrass_M_D10,
    elseif D==30,load weierstrass_M_D30,
    elseif D==50,load weierstrass_M_D50,
    else 
        M=rot_matrix(D,c);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1);
x=x*M;
x=x+0.5;
a = 0.5;%0<a<1
b = 3;
kmax = 20;
[ps,D]=size(x);

c1(1:kmax+1) = a.^(0:kmax);
c2(1:kmax+1) = 2*pi*b.^(0:kmax);
c=-w(0.5,c1,c2);
f=0;
for i=1:D
f=f+w(x(:,i)',c1,c2);
end
f=f+repmat(c*D,ps,1);

%--------------------------------

% 	12.Schwefel's Problem 2.13
function f=schwefel_213(x)%after Fletcher and Powell
global initial_flag
persistent a b A alpha
[ps,D]=size(x);
if initial_flag==0
    initial_flag=1;
    load schwefel_213_data
    if length(alpha)>=D
        alpha=alpha(1:D);a=a(1:D,1:D);b=b(1:D,1:D);
    else
        alpha=-3+6*rand(1,D);
        a=round(-100+200.*rand(D,D));
        b=round(-100+200.*rand(D,D));
    end
    alpha=repmat(alpha,D,1);
    A=sum(a.*sin(alpha)+b.*cos(alpha),2);
end

for i=1:ps
    xx=repmat(x(i,:),D,1);
    B=sum(a.*sin(xx)+b.*cos(xx),2);
    f(i,1)=sum((A-B).^2,1);
end

% 	13. Expanded Extended Griewank's plus Rosenbrock's Function (F8F2)
function fit=EF8F2_func(x)
%-3,1
global initial_flag
persistent  o 
[ps,D]=size(x);
if initial_flag==0
    load EF8F2_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-1+1*rand(1,D);
    end
    initial_flag=1;
end
x=x-repmat(o,ps,1)+1;
fit=0;
for i=1:(D-1)
    fit=fit+F8F2(x(:,[i,i+1]));
end
    fit=fit+F8F2(x(:,[D,1]));
    
function f=F8F2(x)
f2=100.*(x(:,1).^2-x(:,2)).^2+(1-x(:,1)).^2;
f=1+f2.^2./4000-cos(f2);

% ---------------------------------------------------------------  
% 	14. Expanded Rotated Extended Scaffer's F6 	
function f=E_ScafferF6_func(x)
global initial_flag
persistent  o M
fhd=str2func('ScafferF6');
[ps,D]=size(x);
if initial_flag==0
    load E_ScafferF6_func_data
    if length(o)>=D
         o=o(1:D);
    else
         o=-100+200*rand(1,D);
    end
    initial_flag=1;
    c=3;
    if D==2,load E_ScafferF6_M_D2,,
    elseif D==10,load E_ScafferF6_M_D10,
    elseif D==30,load E_ScafferF6_M_D30,
    elseif D==50,load E_ScafferF6_M_D50,
    else 
       M=rot_matrix(D,c);
    end
end
x=x-repmat(o,ps,1);
x=x*M;
f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
    f=f+feval(fhd,x(:,[D,1]));
function f=ScafferF6(x)
f=0.5+(sin(sqrt(x(:,1).^2+x(:,2).^2)).^2-0.5)./(1+0.001*(x(:,1).^2+x(:,2).^2)).^2;
function y = w(x,c1,c2)
y = zeros(length(x),1);
for k = 1:length(x)
	y(k) = sum(c1 .* cos(c2.*x(:,k)));
end
% classical Gram Schmid 
 function [q,r] = cGram_Schmidt (A)
% computes the QR factorization of $A$ via
% classical Gram Schmid 
% 
 [n,m] = size(A); 
 q = A;    
 for j=1:m
     for i=1:j-1 
         r(i,j) = q(:,j)'*q(:,i);
     end
     for i=1:j-1   
       q(:,j) = q(:,j) -  r(i,j)*q(:,i);
     end
     t =  norm(q(:,j),2 ) ;
     q(:,j) = q(:,j) / t ;
     r(j,j) = t  ;
 end 
 
function M=rot_matrix(D,c)
A=normrnd(0,1,D,D);
P=cGram_Schmidt(A);
A=normrnd(0,1,D,D);
Q=cGram_Schmidt(A);
u=rand(1,D);
D=c.^((u-min(u))./(max(u)-min(u)));
D=diag(D);
M=P*D*Q;


