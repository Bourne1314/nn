% Using raw pics data 
import_pics('data\pics.mat')
[errors avg_error] = rbfnet(pics, class, classGlass);

% Using filtered pics
% import_pics('data\filtered_pics.mat')
% Multiply values by 10, because otherwise the values are too small and rbf
% code netlab code complains
% filtered_pics = filtered_pics * 10;
% [errors avg_error] = rbfnet(filtered_pics, class, classGlass);