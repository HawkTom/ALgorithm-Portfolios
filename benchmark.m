function [ fit_r ] = benchmark(id,u,num)
id=id';
fit_r=zeros(1,u);
n=30;
in=(1:n)';
for i=1:u
      x=id(:,i);
    switch num
        case 1  %Sphere Model
            fit_r(i) =  sum(x.^2);
        case 2  %Schwefel's Problem 2.22
            fit_r(i) =  sum(abs(x)) + prod(abs(x));
        case 3 % Schewefel's Problem 1.2
            temp = zeros(n,1);
            for j=1:n
                temp(j) = sum(x(1:j));
            end
            fit_r(i) = sum(temp.^2);
        case 4  % Schwefel's Problem 2.21
            fit_r(i) = max(abs(x));
        case 5 %Generalized Rosenbrock's Function 
            fit_r(i) = sum(100*(id(2:n,i)-id(1:n-1,i).^2).^2 + (id(1:n-1,i)-1).^2);
        case 6 %Step Function
            fit_r(i) = sum(floor(x+0.5).^2);
        case 7 %Quartic Function i.e. Noise
            fit_r(i) = sum(in.*x.^4) + unifrnd(0,0.999999999999);
        case 8  %Generalized Schwefel's Problem 2.26
            fit_r(i) = -sum(x.*sin(sqrt(abs(x))));
        case 9  %Generalized Rastrigin's Function
            fit_r(i) = sum(x.^2-10*cos(2*pi*x)+10);
        case 10 %Ackley's Function
            fit_r(i) = -20*exp(-0.2*rms(x))-exp(rms(cos(2*pi*x)))+20+exp(1);
        case 11 %Generalized Griewank Function
            fit_r(i) = sum(x.^2)/4000 -prod(cos(x./sqrt(in)))+1;
        case 12 %Generalized Penalized Function
            n=30;
            y=1+0.25*(x+1);
            temp=zeros(n,1);
            
            pos = x>10*ones(n,1);
            temp(pos)=100*(x(pos)-10).^4;
            
            pos = x<-10*ones(n,1);
            temp(pos)=100*(-x(pos)-10).^4;
            
            pos = x>-10*ones(n,1) & x<10*ones(n,1);
            temp(pos)=0; 
            
            fit_r(i) = pi*(10*sin(pi*y(1)).^2+sum((y(1:n-1)-1).^2 .* (1+10*sin(pi*y(2:n)).^2))+(y(n)-1)^2)/n+sum(temp);
        case 13 %Generalized Penalized Function
            n=30;
            temp=zeros(n,1);
            
            pos = x>=5*ones(n,1);
            temp(pos)=100*(x(pos)-5).^4;
            
            pos = x<=-5*ones(n,1);
            temp(pos)=100*(-x(pos)-5).^4;
            
            pos = x>-5*ones(n,1) & x<5*ones(n,1);
            temp(pos)=0;  
            
            fit_r(i) = 0.1*( sin(3*pi*x(1)).^2 + sum( (x(1:n-1)-1).^2.*(1+sin(3*pi*x(2:n)).^2) ) + (x(n)-1).^2*(1+sin(2*pi*x(n)).^2))+sum(temp);
        case 14 %Schekel Foxholes Function
            n=2;
            in=1:25;
            a=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;
               -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32 ];
            x=repmat(x,1,25);
            fit_r(i) = (sum((in+sum((x-a).^6)).^-1)+1/500).^-1;
        case 15 %Kowalik's Function
            n=4;
            a=[0.1957 0.1947 0.1735 0.16 0.0844 0.0627 0.0456 0.0342 0.0323 0.0235 0.0246]';
            b=[0.25 0.5 1 2 4 6 8 10 12 14 16]';
            b=1./b;
            fit_r(i)=sum((a-x(1).*(b.^2+x(2).*b)./(b.^2+x(3).*b+x(4))).^2);
        case 16 %Six-Hump Camel-Back Function
            n=2;
            fit_r(i) = 4*x(1)^2-2.1*x(1)^4+(x(1)^6)/3+x(1)*x(2)-4*x(2).^2+4*x(2)^4;
        case 17 %Brain Function
            n=2;
            fit_r(i)=(x(2)-(5.1/(4*pi^2))*x(1).^2+5*x(1)/pi-6).^2+10*(1-1/(8*pi))*cos(x(1))+10;
        case 18 % Goldstein-Price Function
            n=2;
            fit_r(i)=( ((x(1)+x(2)+1)^2) * (19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*(x(2)^2))+1)...
                *(30+((2*x(1)-3*x(2))^2)*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(2)*x(1)+27*(x(2)^2)));
        case 19 %Hartman's Family
            n=4;
            a=[3 10 30;0.1 10 35;3 10 30;0.1 10 35]';
            c=[1 1.2 3 3.2];
            p=[0.3689 0.1170 0.2673;0.4699 0.4387 0.7470;0.1091 0.8732 0.5547;0.03815 0.5743 0.8828]';
            x=repmat(x,1,4);
            fit_r(i)=-sum(c.*exp((-1).*sum(a.*(x-p).^2)));
         case 20 %Hartman's Family
            n=6;
            a=[10 3 17 3.5 1.7 8;0.05 10 17 0.1 8 14;
               3 3.5 1.7 10 17 8;17 8 0.05 10 0.1 14]';
            c=[1 1.2 3 3.2];
            p=[0.1312 0.1696 0.5569 0.0124 0.8283 0.5886; 0.2329 0.4135 0.8307 0.3736 0.1004 0.9991;
               0.2348 0.1451 0.3522 0.2883 0.3047 0.6650; 0.4047 0.8828 0.8732 0.5743 0.1091 0.0381]';
            x=repmat(x,1,4);
            fit_r(i)=-sum(c.*exp((-1).*sum(a.*(x-p).^2)));
        case 21 %Shekel's Family
            n=4;
            a=1.0*[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7]';
            c=[0.1 0.2 0.2 0.4 0.4];
            x=repmat(x,1,5);
            fit_r(i) = -sum((sum((x-a).^2)+c).^-1);
         case 22 %Shekel's Family
            n=4;
            a=1.0*[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3]';
            c=[0.1 0.2 0.2 0.4 0.4 0.6 0.3];
            x=repmat(x,1,7);
            fit_r(i) = -sum((sum((x-a).^2)+c).^-1);
         case 23 %Shekel's Family
            n=4;
            a=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6]';
            c=[0.1 0.2 0.2 0.4 0.4 0.6 0.3 0.7 0.5 0.5];
            x=repmat(x,1,10);
            fit_r(i) = -sum((sum((x-a).^2)+c).^-1);
    end
end

end

  