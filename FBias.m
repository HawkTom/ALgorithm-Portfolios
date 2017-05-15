function  f_bias  = FBias( func_num,str)
if strcmp(str,'benchmark')
switch func_num
    case 8
        f_bias = -1.256948661816488e+04;
    case 14
        f_bias = 0.998003837794449325873406851315;
    case 15
        f_bias = 3.07e-04;
    case 16
        f_bias = -1.03163;
    case 17
        f_bias = 0.397;
    case 18
        f_bias = 2.9;
    case 19
        f_bias = -3.86278214782076;
    case 20
        f_bias =  -3.32236801141557;
    case 21
        f_bias = -10.1532;
    case 22
        f_bias = -10.4030;
    case 23
        f_bias = -10.5365;
    otherwise
        f_bias = 0;
end
else
    switch func_num
        case 1
           f_bias = -450;
        case 2
           f_bias = -450;
        case 3
            f_bias = -450;
        case 4
           f_bias = -450;
        case 5
           f_bias = -310;
        case 6
            f_bias = 390;
        case 7
           f_bias = -180;
        case 8
          f_bias = -140;
        case 9
          f_bias = -330;
        case 10
           f_bias = -330;
        case 11
          f_bias = 90;
        case 12
           f_bias = -460;
        case 13
           f_bias = -130;
        case 14
           f_bias = 300;
    end
end
end



