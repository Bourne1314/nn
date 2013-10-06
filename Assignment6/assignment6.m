function [ som_trained ] = assignment6()
    som_untrained = som(2,[20 20]);
    points = generate_data();
    som_trained = train_my_som(points, som_untrained);
    plot_data_and_nodes(points, som_trained);
end

