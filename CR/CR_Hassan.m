function ratio = CR_Hassan(Ifn,Imov)

    if(all(Ifn(:)==0)|| all(Imov(:)==0))
        ratio =0;
        return;
    end

    %% Calculating RaPTOR
    Nb = 32;        
    n_pts=numel(Ifn(:));
%     Ifs = Ifn*(Nb-1); 
%     Ims = Imn*(Nb-1);    
    IxB = Ifn*Nb;
    b_n = round(IxB) + 1; % bin number
    b_f = IxB - b_n + 2 - .5; % the fraction, used for PV interpolation. between 0 to 1
    b_f_1 = 1 - b_f;

    [CR_n CR_m] = CR_loop1(Imov, b_n, b_f, b_f_1, Nb, n_pts);
    
%     CR_n = zeros(Nb+2, 1); % +2: one before 1st and one after last. number
%     CR_m = zeros(Nb+2, 1); % +2: one before 1st and one after last. summation
%     for ii = 1:n_pts
%         CR_n(b_n(ii))     = CR_n(b_n(ii))   + b_f_1(ii);
%         CR_n(b_n(ii)+1)   = CR_n(b_n(ii)+1) + b_f(ii);
% 
%         CR_m(b_n(ii))     = CR_m(b_n(ii))   + b_f_1(ii)*Imov(ii);
%         CR_m(b_n(ii)+1)   = CR_m(b_n(ii)+1) + b_f(ii)*Imov(ii);
%     end
    
    mu_Imov = sum(Imov(:))/n_pts;
    Sum_Imov2 = sum(Imov(:).^2);

    CR_n(CR_n==0) = 1;
    CR_mean = CR_m ./ CR_n;
    DeNum = n_pts * (Sum_Imov2/n_pts - mu_Imov*mu_Imov);
    ratio = (Sum_Imov2 - sum(CR_m.*CR_mean))/ DeNum;
end