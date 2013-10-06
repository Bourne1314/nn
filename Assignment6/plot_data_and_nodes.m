function plot_data_and_nodes( points, som_trained )
    nodes = sompak(som_trained);
    figure; hold on;
    plot(points(:,1),points(:,2),'.','LineWidth',1);
    plot(nodes(:,1)',nodes(:,2)','+r','LineWidth',1);
    hold off;
end

