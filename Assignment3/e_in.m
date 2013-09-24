function [err] = e_in(fun,orig_points,orig_targets)
    shuffler = randperm(size(orig_points,1));
    shuffled_points = orig_points(shuffler,:);
    shuffled_targets = orig_targets(shuffler,:);
    err = fun(shuffled_points,shuffled_targets,shuffled_points,shuffled_targets);
end
