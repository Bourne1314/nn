function [ angle_of_movement ] = create_angle_of_movement( data )
    angle_of_movement = [];

    for i=1:2:size(data,2),
        x = data(:,i);
        y = data(:,i+1);

        angle = [];

        for j=1:size(x,1)-1,

            dx = x(j+1)-x(j);
            dy = y(j+1)-y(j);

            angle = [angle; atan(dy/dx)];
        end

        % Add zero angle to the last timestep (they stopped)
        angle = [angle; 0];

        angle_of_movement = [angle_of_movement angle];
    end
end

