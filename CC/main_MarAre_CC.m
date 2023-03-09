close all
clear 
clc

% Making 100 Registration Problems for each interval
% Intervals are 0-2, 2-4, 4-6, 6-8, 8-10, 10-12
% Up to 10 Degrees Misalignment in Rotation Parameters
% Up to 7mm Misalignment in Transformation Parameters

NS = 100;
ResDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Results/Renaissance_v1/';

for jj=0:2:10
    %% Misalignment generation unit

    dResult = zeros(NS,1);  
    dInit = zeros(NS,1);
    mTime = zeros(NS,1);  
    xs = zeros(6,NS);

    TEl = jj;
    TEu = TEl+2;

    load(sprintf([ResDir 'xd%i_%i.mat'],TEl,TEu));

    %% Pre-processing + Registration + Validation
    for z=1:NS

        %% Pre-processing unit

        [Im,If] = mkImg3D(xd(:,z));

        %% Registration unit
        tic;
        x = marcel_CC(Im,If,3);
        mTime(z)=toc;

        %% Validation unit
        [d2,d0]=mError(x',xd(:,z));
        disp('Initial Error')
        disp(d0)
        disp('Final Error')
        disp(d2)

%         [Ireg,If]=fTrans(x',Im,If);
        xs(:,z) = x';
        dResult(z) = d2;
        dInit(z) = d0;    
    end

    Succ = dResult<dInit;
    M=[dResult,dInit,Succ];
    ResultsCSV=sprintf([ResDir 'Ren_A8VG_CC/ccA8VG_xd%i_%i.csv'],TEl,TEu);
    csvwrite(ResultsCSV,M);
    save(sprintf([ResDir 'Ren_A8VG_CC/ccA8VG_xd%i_%i.mat'],TEl,TEu),'xs','mTime');
end
