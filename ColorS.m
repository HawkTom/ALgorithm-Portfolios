function [ rgb ] = ColorS( index )

switch index
    case 1
        rgb = [0 0 0];
    case 2
        rgb = [94 38 18];
    case 3
        rgb = [56 94 15];
    case 4
        rgb = [163 148 128];
    case 5
        rgb = [0 0 255];
    case 6
        rgb = [135 38 87];
    case 7
        rgb = [0 199 140];
    case 8
        rgb = [138 43 226];
    case 9
        rgb = [0 224 208];
    case 10
        rgb = [255 0 0 ];
    case 11
        rgb = [255 125 64];
    case 12
        rgb = [255 215 0];
    case 13
        rgb = [0 255 255];
    case 14
        rgb = [255 0 255];
    case 15
        rgb = [255 192 203];
end
rgb = rgb/255;
end

