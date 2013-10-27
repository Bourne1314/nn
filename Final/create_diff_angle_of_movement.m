function [ diff_angle_of_movement ] = create_diff_angle_of_movement( data, angle_of_movement)
    diff_angle_of_movement = [];

    for i=2:size(data,1),
        prev = angle_of_movement(i-1,:);
        curr = angle_of_movement(i,:);

        diff = curr - prev;

        diff_angle_of_movement(i,:) =  diff;
    end
    size(data,2)
    diff_angle_of_movement(size(data,1), :) = zeros(1, (size(data,2)/2));

end

