function [ avg_speed_from_beginning ] = create_avg_speed_from_beginning( speed )
    avg_speed_from_beginning = speed(1,:);

    for i=2:47,
        curr = mean(speed(2:i,:));
        avg_speed_from_beginning(end+1,:) = curr;
    end
end

