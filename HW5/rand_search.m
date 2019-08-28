function [xmax,ymax,zmax] = rand_search(a,b,c,d,N,F)
syms n m

xr = (b - a)*rand(N,1) + a;
yr = (d - c)*rand(N,1) + c;
z = zeros(N,1);
for n = 1:N
    z(n) = double(subs(F,[n,m],[xr(n) yr(n)]));
    
end
[M, I] = max(z);

xmax = xr(I);
ymax = yr(I);
zmax = z(I);
end