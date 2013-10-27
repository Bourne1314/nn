function [ avg_speed_w ] = create_avg_speed_w( data, speed,  w)
    avg_speed_w = speed(1,:);

    for i=2:47,
        w_start = max([1 (i - w)]);
        curr = mean(speed(w_start:i,:));
        avg_speed_w(end+1,:) = curr;
    end
end

