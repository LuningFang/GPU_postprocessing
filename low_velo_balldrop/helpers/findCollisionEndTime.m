% given acceleration find out the time when contact
% start and the index of such contact
function [t_c, index_end] = findCollisionEndTime(acc, time, threshold)
for i = 1:length(acc)
    if time(i) > 0.05 + time(1) && abs(acc(i)) < threshold
        t_c = time(i);
        index_end = i;
        break;
    end
end
end
