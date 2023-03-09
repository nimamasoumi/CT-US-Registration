function f = fRaPTOR_H(x,Im,If,Config)
    
   [Ireg,If]=fTrans(x,Im,If);    
    
    Ifn = If - min(If(:));
    Ifn = Ifn/max(Ifn(:));
    Iregn = Ireg - min(Ireg(:));
    Iregn = Iregn/max(Iregn(:));
    
    [SampleNum,w1,w2,w3]=PatchMask(Config,Iregn);
   
    cr = zeros(1,SampleNum);
    parfor k=1:SampleNum
        cr(k)= CR_Hassan(Ifn(w1(k):w1(k)+Config.PatchSize-1,...
            w2(k):w2(k)+Config.PatchSize-1,w3(k):w3(k)+Config.PatchSize-1),...
            Ireg(w1(k):w1(k)+Config.PatchSize-1,...
            w2(k):w2(k)+Config.PatchSize-1,w3(k):w3(k)+Config.PatchSize-1));
    end
    f = sum(cr)/sum(cr~=0);
end