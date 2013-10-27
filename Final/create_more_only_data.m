function [ data ] = create_more_only_data( data )
    for i=1:2:size(data,2),
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
end
