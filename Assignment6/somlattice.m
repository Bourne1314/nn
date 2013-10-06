function somlattice( som_trained)
%SOMLATTICE Summary of this function goes here
%   Detailed explanation goes here
    sizes = size(som_trained.map);
    x_size = sizes(2);
    y_size = sizes(3);
    %figure;
    hold on;
    for y = 1:y_size
        curr = som_trained.map(:,:,y);
        curr = curr';
        %subplot(1,1,1);
        plot(curr(:,1),curr(:,2),'k');
    end
    for x = 1:x_size
        curr = som_trained.map(:,x,:);
        curr = reshape(curr,2,y_size);
        curr = curr';
        %subplot(1,1,1);
        plot(curr(:,1),curr(:,2),'k');
    end

    hold off;
end

