function [ points ] = generate_data( input_args )
    points = from_gauss_2d(0,0,40,500);
    points = [ points ; from_gauss_2d(150,150,60,250) ];
    points = [ points ; from_gauss_2d(-150,-150,120,125) ];
    points = [ points ; from_gauss_2d(300,-300,20,125) ];
end

