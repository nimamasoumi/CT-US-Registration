clear
close all
clc

%% Misalignment generation unit

% In-practice, this unit should operate in the pre-processing
% The registration problems should be set and fixed before the registration

% Making sufficient problems 
NS = 100;
ResDir='/home/nima/Academics/ImageProcessing/CT_US_Reg/Results/Renaissance_v1';

for k=0:2:10
    
    TEl = k;
    TEu = TEl+2;
    
    xd = MisAlign(NS,TEl,TEu);    
    save(sprintf([ResDir '/xd%i_%i.mat'],TEl,TEu),'xd');
end