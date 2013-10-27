'Generate random people around the initial people'
data = create_more_only_data(data);

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
[distance_from_nearest_agent angle_from_nearest_agent ] = create_distance_and_angle_from_nearest_agent(data);

'all done.'