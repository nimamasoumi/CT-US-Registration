% Pre-processing the CT 

clear
close all
clc

% Below was found by careful inspection of the image around the bone surface
T=270; 
Th = 10;
ResDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Results/Renaissance_v1/Ren_A8VG_CR';
DataDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Data/MyDatabase/A8VG';

load([DataDir '/CT_A8VG.mat']);


If = flip(double(permute(CT,[2,1,3])),2);
IFsch=If>T; 

for k=1:size(If,3)
    I = If(:,:,k);
    
   for j=1:size(I,2)

       v = IFsch(:,j,k);
       if(nnz(v)<1)
        continue;
       end
       w = find(v);
       v = ones(size(v));
       v(w(1)+Th:end)=0;
       I(:,j) = double(I(:,j)).*double(v);

   end
   
   If(:,:,k)=I;
end

If = If.*double(IFsch);

save([ResDir '/If.mat'],'If');

% Correction parameters
x=[0 0 0 0.7500 -3.9269 -0.5];%0.3051
load([DataDir '/US_A8VG.mat']);
Im = flip(double(permute(II,[2,1,3])),2);
[Im,~]=fTrans(x',Im,Im);   
save([ResDir '/Im.mat'],'Im');

