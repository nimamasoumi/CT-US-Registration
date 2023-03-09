function x = marcel_CC(Im,If,Ngp)

% Data storing - 1 -> most coarse level - Ngp -> finest level
LData(Ngp).Im = Im;
LData(Ngp).If = If;
if(Ngp>1)
    for z = 2:Ngp        
        LData(Ngp-z+1).Im = DSample(LData(Ngp-z+2).Im);
        LData(Ngp-z+1).If = DSample(LData(Ngp-z+2).If);
    end
end

%%%%%%%%%%%%% Configuration of Optimization %%%%%%%%%%%%%%
% 4 Levels of pyramid allowed
Lev(Ngp).LevelNum = Ngp;
Lev(Ngp).PatchSize=7;
Lev(Ngp).Threshold=mean(Im(:))/max(Im(:));
Lev(Ngp).Rm = 10;
Lev(Ngp).Tm = 15;
Lev(Ngp).MaxI = 15;
if(Ngp>1)
    Lev(Ngp-1).LevelNum = Ngp-1;
    Lev(Ngp-1).Rm = Lev(Ngp).Rm;Lev(Ngp-1).Tm = Lev(Ngp).Tm/2;
    Lev(Ngp-1).PatchSize=7;
    Lev(Ngp-1).Threshold=Lev(Ngp).Threshold;
    Lev(Ngp-1).MaxI = 50;
    if(Ngp>2)
        Lev(Ngp-2).LevelNum = Ngp-2;
        Lev(Ngp-2).Rm = Lev(Ngp-1).Rm;Lev(Ngp-2).Tm = Lev(Ngp-1).Tm/2;
        Lev(Ngp-2).PatchSize=7;
        Lev(Ngp-2).Threshold=Lev(Ngp).Threshold;
        Lev(Ngp-2).x= [0 0 0 0 0 0]';
        Lev(Ngp-2).MaxI = 100;
        if(Ngp>3)
            Lev(Ngp-3).LevelNum = Ngp-3;
            Lev(Ngp-3).Rm = Lev(Ngp-2).Rm;Lev(Ngp-3).Tm = Lev(Ngp-2).Tm/2;
            Lev(Ngp-3).PatchSize=7;
            Lev(Ngp-3).Threshold=Lev(Ngp).Threshold;
            Lev(Ngp-3).x= [0 0 0 0 0 0]';
            Lev(Ngp-3).MaxI = 100;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lev(1).x = zeros(6,1);
for PyramidLev=1:Ngp    
    Lev(PyramidLev).x = mOptimizerV2_CC(LData(PyramidLev).Im,LData(PyramidLev).If,Lev(PyramidLev));
    if(Ngp>1 && PyramidLev<Ngp)   
        Lev(PyramidLev+1).x = [0 0 0 0 0 0]';
        Lev(PyramidLev+1).x([4 5 6])=2*Lev(PyramidLev).x([4 5 6]);
        Lev(PyramidLev+1).x([1 2 3])=Lev(PyramidLev).x([1 2 3]);
        disp('chocolate')
    end
end
x = Lev(Ngp).x;

end
