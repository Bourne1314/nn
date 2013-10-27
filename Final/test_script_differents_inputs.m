hidden_nodes = [1,2,4,8,16,32];

all_avg_errors = [];

for hidden_node = hidden_nodes,
    [nets errors avg_error] = train_net(input_data, target_value, hidden_node, 100);
    all_avg_errors = [all_avg_errors avg_error];
end

% Plot avg error vs hidden nodes
figure; hold on
axis([0 35 0 1])
set(gca,'XTick', 0:1:35);
set(gca,'YTick', 0:0.1:1);
title('Average error of network per number of hidden nodes');
xlabel('Number of hidden nodes');
ylabel('Average network error');
plot(hidden_nodes, all_avg_errors, '-o');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
encoded_data = mypca(input_data, 10);
hidden_nodes = [1,2,4,8,16,32];

all_avg_errors = [];

for hidden_node = hidden_nodes,
    [nets errors avg_error] = train_net(encoded_data, target_value, hidden_node, 100);
    all_avg_errors = [all_avg_errors avg_error];
end

% Plot avg error vs hidden nodes
figure; hold on
axis([0 35 0 1])
set(gca,'XTick', 0:1:35);
set(gca,'YTick', 0:0.1:1);
title('Average error of network per number of hidden nodes');
xlabel('Number of hidden nodes');
ylabel('Average network error');
plot(hidden_nodes, all_avg_errors, '-o');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
norm_input_data = zscore(input_data);

hidden_nodes = [1,2,4,8,16,32];

all_avg_errors = [];

for hidden_node = hidden_nodes,
    [nets errors avg_error] = train_net(norm_input_data, target_value, hidden_node, 100);
    all_avg_errors = [all_avg_errors avg_error];
end

% Plot avg error vs hidden nodes
figure; hold on
axis([0 35 0 1])
set(gca,'XTick', 0:1:35);
set(gca,'YTick', 0:0.1:1);
title('Average error of network per number of hidden nodes');
xlabel('Number of hidden nodes');
ylabel('Average network error');
plot(hidden_nodes, all_avg_errors, '-o');
hold off