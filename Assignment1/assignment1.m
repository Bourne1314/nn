function [ weights ] = assignment1( data, idx )
    weights = train_dataset([data idx],0.05);
    plot_data_and_decision_boundary(data, idx, weights);
end