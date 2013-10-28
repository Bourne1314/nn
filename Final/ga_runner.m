function [ result ] = ga_runner(data)

    global features;
    features = containers.Map;
    %data = create_more_only_data(data);
    features('source_panic') = [542, 361];
    features('source_matrix') = repmat(features('source_panic'),47,1);
    features('distance_to_source') = create_distance_to_source(data, features('source_panic'));
    features('angle_of_movement') = create_angle_of_movement(data);
    features('speed') = create_speed(data);
    features('distance_to_building') = create_distance_to_buildings(data);
    features('diff_angle_of_movement') = create_diff_angle_of_movement(data, features('angle_of_movement'));
    features('avg_speed_from_beginning') = create_avg_speed_from_beginning(features('speed'));
    features('var_angle_from_beginning') = create_var_angle_from_beginning(features('angle_of_movement'), features('speed'));
    [ angles_toward_center_of_mass distance_toward_center_of_mass ] = create_angles_and_distances_toward_center_of_mass(data);
    features('angles_toward_center_of_mass') = angles_toward_center_of_mass;
    features('distance_toward_center_of_mass') = distance_toward_center_of_mass;
    features('global_mean_speed') = mean(features('speed'),2);
    [ distance_from_nearest_agent angle_from_nearest_agent ] = create_distance_and_angle_from_nearest_agent(data);
    features('distance_from_nearest_agent') = distance_from_nearest_agent;
    features('angle_from_nearest_agent') = angle_from_nearest_agent;

    result = ga(@ga_func, 5);
    
end
