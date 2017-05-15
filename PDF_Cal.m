function pdf = PDF_Cal(Sample)

global VarMax
global nVar
    nSample = size(Sample,2);
    sample = reshape(Sample,nVar,nSample/nVar)';
    if VarMax>1
        sample = sample./VarMax;  
    end
     
     cen = mean(sample);     
     mom2=moment(sample,2);     
     mom3=moment(sample,3);
     mom4=moment(sample,4);
     moment_ = [cen;mom2;mom3;mom4];
     
     pdf=moment_;

end

