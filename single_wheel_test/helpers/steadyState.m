function ss = steadyState(val)
num = length(val);
% find last 20 percent of the value
start = floor(num*0.8);
%start = floor(num*0.8);
length_avg = num-start+1;
avg = mean(val(start:end));
dev = std(val(start:end));
ss = struct('avg', avg, 'dev', dev);
end