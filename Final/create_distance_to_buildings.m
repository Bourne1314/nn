function [ distance_to_building ] = create_distance_to_buildings( data )
    % 4 columns per user (1st is distance to 1st building, 2nd to 2nd, etc...)
    distance_to_building = [];
    max_y = 800;
    points = [546.8, max_y-478.0; 507.5, max_y-330.6; 240.6, max_y-218.6; 184.7, max_y-331.3];

    for i=1:2:size(data,2),
        x = data(:,i);
        y = data(:,i+1);

        for h=1:4,
            p_x = points(h,1); 
            p_y = points(h,2);

            distance = [];

            for j=1:size(x,1),
                distance = [distance; norm([p_x p_y] - [x(j) y(j)])];
            end

            distance_to_building = [distance_to_building distance];
        end
    end

end

