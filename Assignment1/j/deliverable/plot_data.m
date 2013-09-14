function [ ] = plot_data( x, y, classes )
    figure; hold on
    title('Data plot');
    gscatter(x,y,classes,'br','xx')
    hold off
end

