function som_trained = somquiver(mean_x,mean_y,som_trained)
    pak = sompak(som_trained);
    x_range = [min(pak(:,1)),max(pak(:,1))];
    y_range = [min(pak(:,2)),max(pak(:,2))];
    sizes = size(som_trained.map);
    x_size = sizes(2);
    y_size = sizes(3);

    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    hold on;
    plot_index = 0;
    xs = [];
    ys = [];
    for x = 1:x_size
        for y = 1:y_size
            xs = [x xs];
            ys = [y ys];
        end
    end
    u = pak(:,1)/mean_x;
    v = pak(:,2)/mean_y;
    u = u';
    v = v';
    axis([0,x_size+1,0,y_size+1]);
    quiver(xs, ys, u, v,'LineWidth',1);
    hold off
end