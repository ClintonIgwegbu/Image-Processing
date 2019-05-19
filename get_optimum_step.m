function step = get_optimum_step(step_X, X, scheme, N, h, num_stages, equal_mse, tol)
    
    % boolean dct indicates whether dct or pyramid scheme is being used 
    % Returns the quantisation step size that ensures the same rms value
    % as the original image, X, quantised at a step of step_X 
    % num_stages gives size of laplacian pyramid
    % h is filter; low tol gives a more accurate search
    % boolean equal_mse boolean indicates whether equal_mse criterion or
    % const. step size should be used
    % if equal_mse is then search algorithm finds step size for layer 0
    % others may then be obtained using get_equal_mse_ratios
    
    % N must be a power of 2 for colxfm (called in get_rms_dct) to function
    % properly
    
    % set initial step sizes for golden search 
    x1 = 1; 
    x2 = 50;
    
    % pass function as argument only varying parameter, step
    f = @(step) dist_to_rms_X(step, step_X, X, scheme, N, h, num_stages, equal_mse); % objective function
    
    step = golden_search(f, x1, x2, tol);
    
    if strcmp(scheme, 'pyramid')
        if equal_mse == 1
            step = step * get_equal_mse_ratios(X, num_stages);
            
        else
            step = step * ones(1, num_stages);
        end
    end    
    
return 

% note that for dct = false, different results are obtained from that given
% in first interim report as here we deal with Xsym instead of X. The same
% results may be obtained by passing X+128 as a parameter.



