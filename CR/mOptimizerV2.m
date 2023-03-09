% New optimization script which uses the optimization techniques
% have not been used in ARENA

function xo = mOptimizerV2(Im,If,Config)
            
    % Definition of constrains
    Rm = Config.Rm;
    Tm = Config.Tm;
    RmR = Rm*pi/360;
    LB = [-RmR;-RmR;-RmR;-Tm;-Tm;-Tm];
    UB = -LB;
    x = Config.x;
    LevelNum = Config.LevelNum;
       
    
   switch(LevelNum)
        case 3
             options = optimoptions('fmincon','Algorithm','interior-point',...
        'Display','iter-detailed','MaxIterations',Config.MaxI);
        case 2
            options = optimoptions('fmincon','Algorithm','interior-point',...
        'Display','iter-detailed','MaxIterations',Config.MaxI);
        case 1
            options = optimoptions('fmincon','Algorithm','interior-point',...
        'Display','iter-detailed','MaxIterations',Config.MaxI);
        otherwise
            options = optimoptions('fmincon','Algorithm','interior-point',...
        'Display','iter-detailed','MaxIterations',Config.MaxI);
   end
   
   
    xo = fmincon(@(x) fRaPTOR_H(x,Im,If,Config),x,[],[],[],[],LB,UB,[],options);
        
end



