function cc = mXcorr(Ifn,Imn)
        
    num = sum(Ifn(:).*Imn(:));
    den = sqrt(sum(Ifn(:).^2))*sqrt(sum(Imn(:).^2));
    
    cc = num/den;
    
    if(isnan(cc))
        cc=0;
    end

end