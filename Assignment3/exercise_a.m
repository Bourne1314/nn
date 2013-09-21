importfile('data\line.mat');

hidden_nodes = [2,3,4,5,7,10,15,25];

for hidden_node = hidden_nodes,
    net = mlp(1, hidden_node, 1, 'linear');
    
    % apply the model to data
    y = mlpfwd(net, line.x);

    % train the network using the iterative reweighted least squares (IRLS) algorithm
    net = mlptrain(net, line.x, line.t, 100);
    
    error = mlperr(net, line.x, line.t);
    
end