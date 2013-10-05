n = size(data,2);

% Generate random people around the initial people
for i=1:2:n,
    x = data(:,i);
    y = data(:,i+1);
    for j=1:20,
       a = x - 20;
       b = x + 20;
       new_x = a + (b-a) * rand;

       a = y - 20;
       b = y + 20;
       new_y = a + (b-a) * rand;
       
       data = [data new_x new_y];
    end
end

source_panic = [542, 361];
source_matrix = repmat(source_panic,47,1);

n = size(data,2);

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