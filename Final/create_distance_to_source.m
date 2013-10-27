function [ distance_to_source ] = create_distance_to_source( data, source_panic )
    distance_to_source = [];

    for i=1:2:size(data,2),
        x = data(:,i);
        y = data(:,i+1);

        distance = [];

        for j=1:size(x,1),
            distance = [distance; norm(source_panic - [x(j) y(j)])];
        end

        distance_to_source = [distance_to_source distance];
    end
end

