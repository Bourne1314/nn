% Number of samples
m = size(data,1);
% Number of columns
n = size(data,2);

'Generate random people around the initial people'
for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    for j=1:20,
       % Data offset
       a = x - 20;
       b = x + 20;
       % X coordinates for new person with random offset regarding the
       % representative person
       new_x = a + ((rand*(b-a)) + 1) ;
       
       % Introduce noise
       new_x = new_x + rand(47,1) - rand(47,1);

       % Data offset
       a = y - 20;
       b = y + 20;
       % Y coordinates for new person with random offset regarding the
       % representative person
       new_y = a + ((rand*(b-a)) + 1)  ;
       
       % Introduce noise
       new_y = new_y + rand(47,1) - rand(47,1);
       
       % Add new people to the dataset
       data = [data new_x new_y];
    end
end

% New number of columns
n = size(data,2);

source_panic = [542, 361];
source_matrix = repmat(source_panic,47,1);

'Calculate distance to panic source'
distance_to_source = create_distance_to_source(data, source_panic);

'Calculate angle of movement'
angle_of_movement = create_angle_of_movement(data);

'Calculate speed of movement'
speed = create_speed(data);

'Calculate distance to buildings'

% 4 columns per user (1st is distance to 1st building, 2nd to 2nd, etc...)
distance_to_building = create_distance_to_buildings(data);


'Difference in angle of movement'
diff_angle_of_movement = create_diff_angle_of_movement(data, angle_of_movement);

'Average speed from beginning'
avg_speed_from_beginning = create_avg_speed_from_beginning(speed);

'Average speed in the last w timesteps'
w = 5;
avg_speed_w = create_avg_speed_w(data,speed,w);

'Total variance of angle from beginning'
var_angle_from_beginning = create_var_angle_from_beginning(angle_of_movement, speed);

'variance of angle in the last w timesteps'
var_angle_w = create_var_angle_w(data,angle_of_movement,w);

'centroids'
k = 4;
centroids = create_centroids(data,k)

'angles and distance toward centroids'
[ angles_toward_centroids distance_toward_centroids ] = create_angles_and_distances_toward_centroids(data, centroids);

'angles and distance toward global center of mass'
[ angles_toward_center_of_mass distance_toward_center_of_mass ] = create_angles_and_distances_toward_center_of_mass(data);

'global mean speed'
global_mean_speed = mean(speed,2);

'distance and angle from nearest agent'
distance_from_nearest_agent = zeros(size(data,1),(size(data,2)/2));
angle_from_nearest_agent = zeros(size(data,1),(size(data,2)/2));

for j=1:size(data,1),
    % cycle trough time steps
    xs = data(j,(1:2:size(data,2)));
    ys = data(j,(1:2:size(data,2))+1);
        
    for i=1:(size(data,2)/2),
        % cycle trough agents
        curr = [xs(i) ys(i)];

        % copies
        others_xs = xs;
        others_ys = ys;
        
        % and removal of the element
        others_xs(i) = [];
        others_ys(i) = [];
        
        others = [others_xs' others_ys'];
        nearest_index = dsearchn(others,curr);
        nearest = others(nearest_index,:);

        dx = xs(i) - nearest(1);
        dy = ys(i) - nearest(2);
        
        distance_from_nearest_agent(j,i) = sqrt(dx^2 + dy^2);

        angle = atan(dy/dx);
        angle_from_nearest_agent(j,i) = angle;
    end
end

'all done.'