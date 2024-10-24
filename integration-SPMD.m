clc
clearvars
% Creating a parallel pool if none exists
if isempty(gcp())
    parpool();
end
workers = gcp().NumWorkers;
% Define the function
f = @(x,y) x.^3.*y.^3;
% Creating subintervals
x = linspace(-1,1,workers+1);
y = linspace(0,2,workers+1);
% SPMD on the workers
spmd
    xstrt = x(labindex()); %start point of x subinterval
    xend =  x(labindex()+1); %end point of x subinterval
ystrt= y(labindex()); %start point of y subinterval
yend =  y(labindex()+1); %end point of y subinterval
    workint = integral2(f,xstrt,xend,ystrt,yend) % subinterval integration done by each worker
    finalint = gplus(workint) % Adding all individual intergal values.
end
% Getting the complete integration value
totalvalue = finalint{1}
disp('Total integralvalue')
totalvalue