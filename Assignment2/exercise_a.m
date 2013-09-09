data = [ 2 5 7 6 4 2 1 0 0; 0 0 0 1 3 3 5 4 2; 1 2 3 4 5 6 7 8 9 ];

sums_by_class = sum(data(1:2,:)');
total_sum = sum(sums_by_class);
priors = sums_by_class/total_sum;

sums_by_x = sum(data(1:2,:));
prob_x = sums_by_x/total_sum;

joint_probs = data(1:2,:)/total_sum;

conditionals = joint_probs ./ repmat(priors',1,size(joint_probs,2));

posteriors = ( conditionals .* repmat(priors',1,size(joint_probs,2)) ) ./ repmat(prob_x,2,1);
