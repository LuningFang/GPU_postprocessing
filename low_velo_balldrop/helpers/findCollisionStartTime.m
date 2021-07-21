% given acceleration find out the time when contact
% start and the index of such contact
function [t_c, index_start] = findCollisionStartTime(acc, time)
for i = 1:length(acc)
    if abs(acc(i) + 9.8) > 0.01
        t_c = time(i);
        index_start = i;
        break;
    end
end
end
