function [ points ] = from_gauss_2d( center_x, center_y, scale, amount )
%FROM_GAUSS_2D Summary of this function goes here
%   Detailed explanation goes here
    xx = [];
    yy = [];
    for i = 1:amount,
        xx = [xx from_gauss];
        yy = [yy from_gauss];
    end
    xx = xx*scale + center_x;
    yy = yy*scale + center_y;
    points = [xx' yy'];
end

