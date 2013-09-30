function ret = from_gauss
    r = rand(1);
    ret = 0.5;
    incr = 10.0;
    while incr > 0.001;
        if (erf(ret) + 1 ) / 2 > r
            ret = ret - incr;
        else 
            ret = ret + incr;
        incr = incr / 2;
        end
    end
end