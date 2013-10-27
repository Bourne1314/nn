function [ distance_from_nearest_agent angle_from_nearest_agent ] = create_distance_and_angle_from_nearest_agent( data )
    distance_from_nearest_agent = zeros(size(data,1),(size(data,2)/2));
    angle_from_nearest_agent = zeros(size(data,1),(size(data,2)/2));

    for j=1:size(data,1),
        % cycle trough time steps
        xs = data(j,(1:2:size(data,2)));
        ys = data(j,(1:2:size(data,2))+1);

        for i=1:(size(data,2)/2),
            % cycle trough agents
            curr = [xs(i) ys(i)];

            % copies
            others_xs = xs;
            others_ys = ys;

            % and removal of the element
            others_xs(i) = [];
            others_ys(i) = [];

            others = [others_xs' others_ys'];
            nearest_index = dsearchn(others,curr);
            nearest = others(nearest_index,:);

            dx = xs(i) - nearest(1);
            dy = ys(i) - nearest(2);

            distance_from_nearest_agent(j,i) = sqrt(dx^2 + dy^2);

            angle = atan(dy/dx);
            angle_from_nearest_agent(j,i) = angle;
        end
    end


end

