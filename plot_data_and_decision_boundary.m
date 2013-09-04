function [ ] = plot_data_and_decision_boundary( data, idx )
    xx = [-20;0.1;40];
    scatterplot([[xx',ff(train_dataset([data idx],0.05),xx')];data])
    disp(xx);
end
