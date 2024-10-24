clc, clearvars
n=input('Enter n: ');
function timeconsumingfun    
pauset= randi([1, 5]);
pause(pauset)
end
tic
  timeconsumingfun
toc
%Finding the time taken in FOR loop
tic
for i=1:n
    timeconsumingfun
end
t1 = toc
%Finding the time taken in parallel loop
if isempty(gcp())
    parpool();
end
% Utilize multiple cores to run embarrasingly parallel computations
tic
parfor i=1:n
    timeconsumingfun
end
tp = toc
%Calculating the speedup and efficiency
speedup=t1/tp
efficiency=(speedup/gcp().NumWorkers)*100