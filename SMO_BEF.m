function [E_alpha,E_beta] = SMO_BEF(we_est,U_alpha,U_beta,I_alpha,I_beta)

% the aim of the function is to calculate the E_alpha and E_beta

Ld = 0.0007215;
Lq = 0.001218;
Rs = 0.11;

SMO_h = 500;

delta_t = 1e-6;

matrix_paramter = [-(Rs/Ld),-we_est*(Ld-Lq)/Ld ; we_est*(Ld-Lq)/Ld,-(Rs/Ld)];

matrix_u = [U_alpha ; U_beta];

persistent matrix_iest;
if isempty(matrix_iest)
    matrix_iest = [0 ; 0];
end

persistent matrix_E;
if isempty(matrix_E)
    matrix_E = [0 ; 0];
end

matrix_iest = matrix_iest + delta_t*(matrix_paramter*matrix_iest + (1/Ld)*matrix_u - (1/Ld)*matrix_E);

if(matrix_iest(1)>=I_alpha)
    matrix_E(1) = SMO_h;
end

if(matrix_iest(1)<I_alpha)
    matrix_E(1) = -SMO_h;
end

if(matrix_iest(2)>=I_beta)
    matrix_E(2) = SMO_h;
end

if(matrix_iest(2)<I_beta)
    matrix_E(2) = -SMO_h;
end

%output   

E_alpha = matrix_E(1);
E_beta = matrix_E(2);

end
    
        
        
        