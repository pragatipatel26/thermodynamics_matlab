function dG_vdw = vdw_fugacity(a,b,P,T)
% returns delta G for the van der walls gas as a function of
% a, b, P and T. Note, pass P as an array so that we can calculate dG_vdw at different P values.

% YOUR CODE HERE
% write a separate function that takes in a, b, P, and T and returns the van der
% walls volume and call it here
vol=volume(a,b,P,T);

% calculate ln(f)
ln_f = log(vol ./ (vol - b)) + b * (1 ./ (vol - b)) ...
 - ((2 * a) ./ (8.314 * T)) * (1 ./ vol) - log((P .* vol)/(8.314 * T)) + log(P);

dG_vdw=8.314*T.*(ln_f-ln_f(1));



end