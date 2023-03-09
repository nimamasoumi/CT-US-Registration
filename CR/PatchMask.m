function [SampleNum,w1,w2,w3]=PatchMask(Config,Imn)
     
    PatchSize = Config.PatchSize;
    Threshold = Config.Threshold;
    LevelNum = Config.LevelNum;
    Barr = floor(size(Imn)/4);
    if(Barr(3)<PatchSize)
        Barr(3)=PatchSize;
    end
    TempI = zeros(size(Imn));
    TempI(1:size(Imn,1)-2*Barr(1)+1,...
        Barr(2)+1:size(Imn,2)-Barr(2)+1,...
        floor(size(Imn,3)/4)+1:size(Imn,3)-Barr(3)+1) = 1;
    try        
        Imn = Imn.*TempI;
        temp = find(Imn>Threshold);
        [psx,psy,psz] = ind2sub(size(Imn),temp);

%         switch(LevelNum)
%             case 3
%                 SampleNum = ceil(size(Imn,1)*size(Imn,2)*numel(psx)/numel(Imn)/10);
%             case 2
%                 SampleNum = ceil(size(Imn,1)*size(Imn,2)*numel(psx)/numel(Imn));
%             case 1
%                 SampleNum = ceil(2*size(Imn,1)*size(Imn,2)*numel(psx)/numel(Imn));
%             otherwise
%                 SampleNum = ceil(size(Imn,1)*size(Imn,2)*numel(psx)/numel(Imn)/10);
%         end

%         psx = psx(psx<= max(psx(:))-PatchSize+1);
%         psy = psy(psy<= max(psy(:))-PatchSize+1);
%         psz = psz(psz<= max(psz(:))-PatchSize+1);
        

        

        SampleNum = numel(psx);

        
%         w1 = psx(randi(numel(psx),1,SampleNum))';
%         w2 = psy(randi(numel(psy),1,SampleNum))';
%         w3 = psz(randi(numel(psz),1,SampleNum))';

    w1 = psx;
    w2 = psy;
    w3 = psz;

    catch
        Imn
        psx
        SampleNum
    end
end