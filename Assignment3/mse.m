function ret = mse(y,t)
    d = diag(dist2(y,t));
    ret = mean(d);
end
