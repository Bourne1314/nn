function [ angles_toward_centroids distance_toward_centroids ] = create_angles_and_distances_toward_centroids( data, centroids )
    k = size(centroids, 2)/2;
    angles_toward_centroids = zeros(size(data,1),k*(size(data,2)/2));
    distance_toward_centroids = zeros(size(data,1),k*(size(data,2)/2));
    for j=1:size(data,1),
        % cycle trough time steps

        for i=1:(size(data,2)/2),
            % cycle trough points, regardless of time step
            x = data(j,(i*2)-1);
            y = data(j,i*2);

            angle = [];
            for c = 1:k,
                % cycle trough the centroids
                dx = x - centroids(j,(c*2)-1);
                dy = y - centroids(j,(c*2));

                distance_toward_centroids(j,i) = sqrt(dx^2 + dy^2);

                angle = atan(dy/dx);

                index = i * k + c;
                angles_toward_centroids(j,index) = angle;
            end
        end
        % Add zero angle to the last timestep (they stopped)
    end
end
