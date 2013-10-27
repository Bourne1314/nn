% Function   :  calculate_error 
% 
% Purpose    :  This function calculates the MSE between a set 
%               of given classes and a set of predicted classes 
% 
% Parameters :  + real_class - the real, known classes for every data point
%               + predicted_class - the predicted classes for every data point
%
% Return     :  The MSE between the real classes and the predicted
%               classes
function [error] = mse_error(real_class, predicted_class)
   D = abs(real_class-predicted_class).^2;
   error = sum(D(:))/numel(real_class);
end