function [ som_trained ] = assignment6( )
    points = from_gauss_2d(0,0,40,500);
    points = [ points ; from_gauss_2d(150,150,60,250) ];
    points = [ points ; from_gauss_2d(-150,-150,120,125) ];
    points = [ points ; from_gauss_2d(300,-300,20,125) ];
    
    som_untrained = som(2,[4 4]);
    options = zeros(1,18);
    options(1) = 0; % display error values
    options(5) = 1; % is sampled randomly with replacement
    options(6) = 1; % 1: batch algorithm; 0 (the default): on-line algorithm
    options(14) = 5000; % number of iterations
    options(15) = 8; % initial neighborhood
    options(16) = 0.01; % final learning rate
    options(17) = 1; % final neighborhood
    options(18) = 0.1; % initial learning rate
    som_trained = somtrain(som_untrained, options, points);
    nodes = sompak(som_trained);
    plot(points(:,1),points(:,2),'.',nodes(:,1)',nodes(:,2)','*')
end

