function som_trained = plot_lattices_while_training( points, som_untrained )
    howmany_rows = 8;
    howmany_cols = 6;
    howmany = howmany_cols*howmany_rows;
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    colordef white;
    figure('Color',[1.0 1.0 1.0]);
    axis off;
    hold on;
    som_trained = som_untrained;
    for z = 1:howmany
        subaxis(howmany_rows,howmany_cols,z, 'Spacing', 0.01, 'Padding', 0, 'Margin', 0);
        %subplot(howmany_rows,howmany_cols,z);
        set(gca,'YTick',[]);
        set(gca,'XTick',[]);
        colordef white
        axis off;
        somlattice(som_trained);
        som_trained = train_my_som(points, som_trained);
    end
    hold off
end

