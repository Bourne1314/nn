function [ ] = plot_data_and_decision_boundary( data, idx, weights )
    xxmin = min(data(:,1));
    xxmax = max(data(:,1));
    xxgap = (xxmax-xxmin)/1000;
    xx = [xxmin:xxgap:xxmax];
    yy = ff(weights,xx);
    points = [[xx',yy'];data];
    line_points_size = size(xx);
    classes = [zeros(line_points_size(2),1) + 7;idx];
    disp([size(xx), size(yy), size(points(:,1)),size(points(:,2)),size(classes)]);
    gscatter(points(:,1),points(:,2),classes,'brg','xx.');
end