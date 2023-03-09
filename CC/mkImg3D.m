function [Im,If]=mkImg3D(xd)

%     DataDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Data/MyDatabase/A8VG';
    ResDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Results/Renaissance_v1/Ren_A8VG_CC';

%     load([ResDir 'test/Isyn.mat']);
%     load([ResDir 'test/If.mat']);
    load([ResDir '/If.mat']);
    load([ResDir '/Im.mat']);
%     load([DataDir '/US_A8VG.mat']);
    
    %load ../../Data/MyDatabase/P1/L2/Case1.mat
%     load ../../../Data/MyDatabase/P1/L2/Im.mat

%     Im = flip(double(permute(II,[2,1,3])),2);    

%     [Gx,Gy,Gz]=imgradientxyz(Im);
        
    Im = double(Im);%Change this later
    If = double(If);

    [Im,If]=fTrans(xd,Im,If);   

end

