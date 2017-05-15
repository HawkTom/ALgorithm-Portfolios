
clear;clc;
figure(1);
for func_num=1:6
    
    if func_num==1 x=-100:5:100;y=x; %[-100,100]
    elseif func_num==2 x=-100:5:100; y=x;%[-10,10]
    elseif func_num==3 x=-100:5:100; y=x;%[-100,100]
    elseif func_num==4 x=-100:2:0; y=x+100;%[-100,100]
    elseif func_num==5 x=-200:20:200;y=x; %[-5,5]
    elseif func_num==6 x=78:0.05:82; y=-51.3:0.05:-47.3;%[-3,1]
    elseif func_num==7 x=-350:2:-250; y=-100:2:0;;%[-600,600]
    elseif func_num==8 x=-32:1:32; y=x;%[-32,32]
    elseif func_num==9 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==10 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==11 x=-0.5:0.01:0.5; y=x;%[-0.5,0.5]
    elseif func_num==12 x=-3:0.1:3; y=x;%[-pi,pi]
    elseif func_num==13 x=-2:0.02:-1; y=x;%[-3,1]
    elseif func_num==14 x=-90:0.2:-50; y=-40:0.2:0;%[-100,100]
    elseif func_num==15 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==16 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==17 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==18 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==19 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==20 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==21 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==22 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==23 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==24 x=-5:0.1:5; y=x;%[-5,5]
    elseif func_num==25 x=-5:0.1:5; y=x;%[-5,5]
    end
    
    r=[];   t=[];
    for i=1:length(x)
        for j=1:length(y)
            temp1 = [x(i);y(j)];
            r=[r,temp1];
        end
    end
    z = FitFunc_cec(r,size(r,2),func_num);
    for i=1:length(x)
        for j=1:length(y)
            t(i,j) = z((i-1)*length(y)+j);
        end
    end
    subplot(2,3,func_num);
    surfc(x,y,t);
    r=r';
end






