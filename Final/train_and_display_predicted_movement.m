clear all
load data\dataset_final_assignment
create_more_data

%Randomly select 120 unique people for testing. The rest will be used for
%training
rng(10);
a = rand(1000,1);
b = unique(a);
c = 1 + (b .* (735 - 1)) + 1;
c = round(c);
d = unique(c);
idx = randperm(length(d));
xperm = d(idx);
test_indices = xperm(1:120);
test_indices = test_indices';
train_indices = [1:735];
train_indices(test_indices)=[];

% Get the train data
train_input_data=[];
train_target_value=[];
for i=train_indices,
       train_input_data = [ train_input_data; 
           speed(:,i) ...
           angle_of_movement(:,i) ... 
           distance_to_source(:,i) ...
           diff_angle_of_movement(:,i) ...
           avg_speed_from_beginning(:,i) ...
           avg_speed_w(:,i) ...
           var_angle_w(:,i) ...
           var_angle_from_beginning(:,i)  ...
           angles_toward_centroids(:,(i*4)-((4)-1):i*4) ...
           distance_toward_centroids(:,(i*4)-((4)-1):i*4) ...
           angles_toward_center_of_mass(:,i) ...
           distance_toward_center_of_mass(:,i) ...
           global_mean_speed(:,:) ...
           distance_from_nearest_agent(:,i) ...
           distance_to_building(:,(i*4)-3:i*4) ...
       ];
       train_target_value = [ train_target_value; speed(:,i) angle_of_movement(:,i)];
end

train_input_data(isnan(train_input_data))=0;
train_target_value(isnan(train_target_value))=0;

rand_idx = randperm(size(train_input_data,1));

train_input_data = train_input_data(rand_idx,:);
train_target_value = train_target_value(rand_idx,:);

% Create neural net
net = mlp(size(train_input_data,2), 24, size(train_target_value,2), 'linear');            

% Train the network
net = mlptrain(net, train_input_data, train_target_value, 3000);

% Get the predictions for the test population
all_y = [];
for i=test_indices,
    
       test_input_data = [speed(:,i) ...
           angle_of_movement(:,i) ... 
           distance_to_source(:,i) ...
           diff_angle_of_movement(:,i) ...
           avg_speed_from_beginning(:,i) ...
           avg_speed_w(:,i) ...
           var_angle_w(:,i) ...
           var_angle_from_beginning(:,i)  ...
           angles_toward_centroids(:,(i*4)-((4)-1):i*4) ...
           distance_toward_centroids(:,(i*4)-((4)-1):i*4) ...
           angles_toward_center_of_mass(:,i) ...
           distance_toward_center_of_mass(:,i) ...
           global_mean_speed(:,:) ...
           distance_from_nearest_agent(:,i) ...
           distance_to_building(:,(i*4)-3:i*4) ...
       ];
   
   test_input_data(isnan(test_input_data))=0;
   
   all_y = [all_y mlpfwd(net, test_input_data)]; 
   
end

% Get initial coordinates for the test population
test_population_coordinates = [];

for i=test_indices,
    test_population_coordinates= [test_population_coordinates data(:,(i*2)-1) data(:,(i*2))];
end

initial_coordinates = test_population_coordinates(1,:);

estimated_position = zeros(size(test_population_coordinates,1),size(test_population_coordinates,2));
for i = 1:size(initial_coordinates,2)/2,
    
    estimated_position(1,(i*2)-1) = initial_coordinates(1, (i*2)-1);
    estimated_position(1,(i*2)) = initial_coordinates(1, (i*2));
    
    for j = 2:size(test_population_coordinates,1),
        
        x_ = estimated_position(j-1,(i*2)-1);
        y_ = estimated_position(j-1,(i*2));

        distance_x = all_y(j,(i*2)-1) * cos(all_y(j,(i*2)));
        distance_y = all_y(j,(i*2)-1) * sin(all_y(j,(i*2)));    
               
        estimated_position(j, (i*2)-1) = (x_ + distance_x);
        estimated_position(j, (i*2)) = (y_ + distance_y);

    end
end

test_plot_data