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
distance_to_source = [];

for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    
    distance = [];
    
    for j=1:size(x,1),
        distance = [distance; norm(source_panic - [x(j) y(j)])];
    end
    
    distance_to_source = [distance_to_source distance];
end

'Calculate angle of movement'
angle_of_movement = [];

for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    
    angle = [];
    
    for j=1:size(x,1)-1,
        
        dx = x(j+1)-x(j);
        dy = y(j+1)-y(j);
        
        angle = [angle; atan(dy/dx)];
    end
    
    % Add zero angle to the last timestep (they stopped)
    angle = [angle; 0];
    
    angle_of_movement = [angle_of_movement angle];
end

'Calculate speed of movement'
speed = [];

for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    
    sp = [];
    
    for j=1:m-1,
        tmp = (max(x(j),x(j+1))-min(x(j),x(j+1)))+(max(y(j),y(j+1))-min(y(j),y(j+1)));
        sp = [sp; tmp];
    end
    
    % Add zero speed to the last time (they stopped)
    sp = [sp; 0];
    
    speed = [speed sp];
end

max_y = 800;
points = [546.8, max_y-478.0; 507.5, max_y-330.6; 240.6, max_y-218.6; 184.7, max_y-331.3];

'Calculate distance to buildings'
% 4 columns per user (1st is distance to 1st building, 2nd to 2nd, etc...)
distance_to_building = [];
    
for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);

    for h=1:4,
        p_x = points(h,1); 
        p_y = points(h,2);

        distance = [];

        for j=1:size(x,1),
            distance = [distance; norm([p_x p_y] - [x(j) y(j)])];
        end

        distance_to_building = [distance_to_building distance];
    end
end

'Difference in angle of movement'
diff_angle_of_movement = [];

for i=1:n/2,
    prev = angle_of_movement(:,i-1);
    curr = angle_of_movement(:,i);
    
    diff = curr - prev;
    
    diff_angle_of_movement = [diff_angle_of_movement diff];
end

'Average speed from beginning'
avg_speed_from_beginning = speed(1,:);

for i=2:47,
    curr = mean(speed(2:i,:));
    avg_speed_from_beginning(end+1,:) = curr;
end

'Average speed in the last w timesteps'
w = 5;
avg_speed_w = speed(1,:);

for i=2:47,
    w_start = max([1 (i - w)]);
    curr = mean(speed(w_start:i,:));
    avg_speed_w(end+1,:) = curr;
end

'Total variance of angle from beginning'
var_angle_from_beginning = speed(1,:);

for i=2:47,
    curr = var(speed(2:i,:));
    var_angle_from_beginning(end+1,:) = curr;
end

'variance of angle in the last w timesteps'
var_angle_w = zeros(1,size(angle_of_movement,2));

for i=2:47,
    w_start = max([1 (i - w)]);
    curr = var(angle_of_movement(w_start:i,:));
    var_angle_w(end+1,:) = curr;
end

'centroids'
k = 4;
centroids = zeros(0,2*k);
for i=1:47,
    x1 = data(i,(1:2:size(data,2)));
    y1 = data(i,(1:2:size(data,2))+1);
    indexes = [];
    for j=1:k,
        % get random point as centroid
        indexes = [indexes ceil(rand*(size(data,2)/2))];
    end
    centroids_x = x1(:,indexes);
    centroids_y = y1(:,indexes);
    init_centroids = [centroids_x' centroids_y'];
    points = [x1' y1'];
    options = zeros();
    options(14) = 1000; % number of iterations
    curr_centroids = kmeans(init_centroids, points, options);
    curr_centroids_flat = reshape(curr_centroids,1,2*k);
    centroids = [centroids ; curr_centroids_flat];
end

'angles toward centroids'
angles_toward_centroids = zeros(size(data,1),k*(size(data,2)/2));
for j=1:size(data,1),
    % cycle trough time steps

    for i=1:(size(data,2)/2),
        % cycle trough points, regardless of time step
        x = data(j,(i*2)-1);
        y = data(j,i*2);
    
        angle = [];
        for c = 1:k,
            % cycle trough the centroids
            dx = x - centroids(j,(c*2)-1);
            dy = y - centroids(j,(c*2));

            angle = atan(dy/dx);
            
            index = i * k + c;
            angles_toward_centroids(j,index) = angle;

        end
    end
    
    % Add zero angle to the last timestep (they stopped)
    
end

'angles and distance toward global center of mass'
angles_toward_center_of_mass = zeros(size(data,1),(size(data,2)/2));
distance_toward_center_of_mass = zeros(size(data,1),(size(data,2)/2));
for j=1:size(data,1),
    % cycle trough time steps
    xs = data(j,(1:2:size(data,2)));
    ys = data(j,(1:2:size(data,2))+1);
    
    center_x = mean(xs);
    center_y = mean(ys);
    
    for i=1:(size(data,2)/2),
        % cycle trough agents
        x = data(j,(i*2)-1);
        y = data(j,i*2);
    
        dx = x - center_x;
        dy = y - center_y;
        
        distance_toward_center_of_mass(j,i) = sqrt(dx^2 + dy^2);
        
        angle = atan(dy/dx);
        
        angles_toward_center_of_mass(j,i) = angle;
    end
    
    % Add zero angle to the last timestep (they stopped)
    
end

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