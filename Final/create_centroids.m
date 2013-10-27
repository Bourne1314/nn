function [ centroids ] = create_centroids( data, k )

    centroids = zeros(0,2*k);
    for i=1:47,
        x1 = data(i,(1:2:size(data,2)));
        y1 = data(i,(1:2:size(data,2))+1);
        indexes = [];
        for j=1:k,
            % get random point as centroid
            indexes = [indexes ceil(rand*(size(data,2)/2))];
        end
        centroids_x = x1(:,indexes);
        centroids_y = y1(:,indexes);
        init_centroids = [centroids_x' centroids_y'];
        points = [x1' y1'];
        options = zeros();
        options(14) = 1000; % number of iterations
        curr_centroids = kmeans(init_centroids, points, options);
        curr_centroids_flat = reshape(curr_centroids,1,2*k);
        centroids = [centroids ; curr_centroids_flat];
    end
end