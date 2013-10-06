function plot_while_training( points, som_untrained )
    howmany_cols = 5;
    hold on;
    meanpoints = mean(points);
    som_trained = som_untrained;
    for z = 1:howmany_cols
        subplot(howmany_cols,2,(z*2)-1);
        somlattice(som_trained);
        subplot(howmany_cols,2,z*2);
        somquiver(meanpoints(1),meanpoints(2),som_trained);
        som_trained = train_my_som(points, som_trained);
    end
    hold off
end

