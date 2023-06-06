function id_ref   = MTPA_id(iq,is)

    %this function is used to calculate the id_ref
    %Both search-based and model-based
    
    %parameter of the IPMSM
    Ld = 0.0007215;
    Lq = 0.001218;
    Fr = 0.1119;
    
    isreg1 = 0;
    isreg2 = 0;
    
    persistent delta_id;
    if isempty(delta_id)
        delta_id = -1e-4;
    end
    
    persistent idref_reg;
    if isempty(idref_reg)
        idref_reg = 0;
    end
    
    persistent is_last;
    if isempty(is_last)
        is_last = zeros(1000,1);
    end
    
    persistent iqreg;
    if isempty(iqreg)
        iqreg = 0;
    end
    
    iqreg = iq;
    
    idref_reg = idref_reg + delta_id;
    
    for countFor = 1:500
        isreg1 = isreg1 + is_last(countFor);
        isreg2 = isreg2 + is_last(countFor+500);
    end
    
    if isreg1>=isreg2+20
        delta_id = -delta_id;
    end
    
    % model-based
    % idref_reg = ( -Fr + sqrt(Fr*Fr+4*(Ld-Lq)*(Ld-Lq)*iqreg*iqreg) )/(2*(Ld-Lq));
    
    % search-based
    idref_reg = idref_reg;
    
    % No MTPA
    % idref_reg = 0;
    
    %output id_ref
    id_ref = idref_reg;  
    
    for countFor = 1:999
        is_last(1001-countFor) = is_last(1000-countFor);
    end
    is_last(1) = is;
    
    end
        
                
                