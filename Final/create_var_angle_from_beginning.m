function [ var_angle_from_beginning ] = create_var_angle_from_beginning( angle_of_movement, speed )
var_angle_from_beginning = angle_of_movement(1,:);

for i=2:47,
    curr = var(speed(2:i,:));
    var_angle_from_beginning(end+1,:) = curr;
end

end

