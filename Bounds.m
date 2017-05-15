function [ x_max,x_min,D ] = Bounds( func_num,fun_str)
if strcmp(fun_str,'benchmark')
    switch func_num
        case 1
            x_max=100;       x_min=-100;     D=30;
        case 2
            x_max=10;        x_min=-10;      D=2;
        case 3
            x_max=100;       x_min=-100;     D=30;
        case 4
            x_max=100;       x_min=-100;     D=30;
        case 5
            x_max=30;        x_min=-30;      D=30;
        case 6
            x_max=100;       x_min=-100;     D=30;
        case 7
            x_max=1.28;      x_min=-1.28;    D=30;
        case 8
            x_max=500;       x_min=-500;     D=30;
        case 9
            x_max=5.12;      x_min=-5.12;    D=30;
        case 10
            x_max=32;        x_min=-32;      D=30;
        case 11
            x_max=600;       x_min=-600;     D=30;
        case 12
            x_max=50;        x_min=-50;      D=30;
        case 14
            x_max=65.536;    x_min=-65.536;  D=2;
        case 13
            x_max=50;        x_min=-50;      D=30;
        case 15
            x_max=5;         x_min=-5;       D=4;
        case 16
            x_max=5;         x_min=-5;       D=2;
        case 17
            x_max=15;        x_min=-15;      D=2;
        case 18
            x_max=2;         x_min=-2;       D=2;
        case 19
            x_max=1;         x_min=0;        D=3;
        case 20
            x_max=1;         x_min=0;        D=6;
        case 21
            x_max=10;        x_min=0;        D=4;
        case 22
            x_max=10;        x_min=0;        D=4;
        case 23
            x_max=10;        x_min=0;        D=4;
    end
else
    switch func_num
        case 1
            x_max=100;       x_min=-100;     D=30;
        case 2
            x_max=100;        x_min=-100;      D=30;
        case 3
            x_max=100;       x_min=-100;     D=30;
        case 4
            x_max=100;       x_min=-100;     D=30;
        case 5
            x_max=100;         x_min=-100;       D=30;
        case 6
            x_max=100;       x_min=-100;     D=30;
        case 7
            x_max=600;       x_min=-600;     D=30;
        case 8
            x_max=32;        x_min=-32;      D=30;
        case 9
            x_max=5;         x_min=-5;       D=30;
        case 10
            x_max=5;         x_min=-5;       D=30;
        case 11
            x_max=0.5;      x_min=-0.5;     D=30;
        case 12
            x_max=pi;        x_min=-pi;      D=30;
        case 13
            x_max=1;         x_min=-3;       D=30;
        case 14
            x_max=100;       x_min=-100;     D=30;
    end
end

