input_data = [];
target_value = [];

for i=1:size(data,2)/2,
   input_data = [ input_data; speed(:,i) angle_of_movement(:,i) distance_to_source(:,i) diff_angle_of_movement(:,i) avg_speed_from_beginning(:,i) avg_speed_w(:,i) var_angle_w(:,i) var_angle_from_beginning(:,i)  angles_toward_centroids(:,(i*k)-((k)-1):i*k) distance_toward_centroids(:,(i*k)-((k)-1):i*k) angles_toward_center_of_mass(:,i) distance_toward_center_of_mass(:,i) global_mean_speed(:,:) distance_from_nearest_agent(:,i) distance_to_building(:,(i*4)-3:i*4)];
   target_value = [ target_value; speed(:,i) angle_of_movement(:,i)];
end

