function [ ] = plot_data_and_decision_boundary( data, idx )
    xxmin = min(data(:,1));
    xxmax = max(data(:,1));
    xxgap = (xxmax-xxmin)/1000;
    xx = [xxmin:xxgap:xxmax];
    yy = ff(train_dataset([data idx],0.05),xx);
    scatterplot([[xx',yy'];data]);
end
