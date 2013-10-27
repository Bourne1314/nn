function [ angles_toward_center_of_mass distance_toward_center_of_mass ] = create_angles_and_distances_toward_center_of_mass( data )
    angles_toward_center_of_mass = zeros(size(data,1),(size(data,2)/2));
    distance_toward_center_of_mass = zeros(size(data,1),(size(data,2)/2));
    for j=1:size(data,1),
        % cycle trough time steps
        xs = data(j,(1:2:size(data,2)));
        ys = data(j,(1:2:size(data,2))+1);

        center_x = mean(xs);
        center_y = mean(ys);

        for i=1:(size(data,2)/2),
            % cycle trough agents
            x = data(j,(i*2)-1);
            y = data(j,i*2);

            dx = x - center_x;
            dy = y - center_y;

            distance_toward_center_of_mass(j,i) = sqrt(dx^2 + dy^2);

            angle = atan(dy/dx);

            angles_toward_center_of_mass(j,i) = angle;
        end
        % Add zero angle to the last timestep (they stopped)
    end
end
