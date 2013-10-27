function [ speed ] = create_speed( data )
    speed = [];
    m = size(data,1);
    for i=1:2:size(data,2),
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

end

