function [ learning_rates mses ] = different_learning_rates( dataset )
    learning_rates = [0:0.001:1];
    mses = [];
    for lr=learning_rates,
        weights = train_dataset(dataset, lr);
        curr_mse = mse_dataset(weights, dataset);
        mses = [ mses curr_mse];
    end
end
