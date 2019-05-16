C8 = dct_ii(8); 
plot(C8');

Xsym = X - 128; % ensure X has zero-mean otherwise dc coefficients of transform 
             % would be purely positive and others would be symmetrically
             % distributed about 0 - why is this problematic? how does this
             % make X zero mean anyway?
             
          
Y = colxfm(colxfm(Xsym,C8)',C8)';

N = 8; draw(regroup(Y,N)/N); % divide by N to counter gain of DCT transform

Z = colxfm(colxfm(Y',C8')',C8'); draw(Z);
max(abs(Xsym(:)-Z(:)))

bases = [zeros(1,8); C8'; zeros(1,8)]; 
draw(255*bases(:)*bases(:)');

step = 17;
Yq = quantise(Y, step); 
Yr = regroup(Yq,N)/N; 
