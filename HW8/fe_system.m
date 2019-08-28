function [xa,ya] = fe_system(h,x0,y0,xN,f)
    
    syms x1 x2
    
    N = ceil((xN-x0)/h)+1;

    ya = zeros(N,2);
    ya(1,:)=y0;

    xa = x0:h:xN;

    for i=2:N
        ya(i,:)=ya(i-1,:) + h*subs(f, [x1,x2], [ya(i-1,1),ya(i-1,2)]);
    end
end