% Initialize the data with the example from the lecture
data = [ 2 5 7 6 4 2 1 0 0; 0 0 0 1 3 3 5 4 2; 1 2 3 4 5 6 7 8 9 ];

% Calculate the number of occurrences per class
sums_by_class = sum(data(1:2,:)');

% Calculate the total number of occurrences
total_sum = sum(sums_by_class);

% Calculate the prior probabilites 
% Example: P(C1) = num. of of samples in C1-row/num. all samples
priors = sums_by_class/total_sum;

% Calculate the number of events for every xl
sums_by_x = sum(data(1:2,:));

% Calculate the probability of an ocurrence belonging to a given x
prob_x = sums_by_x/total_sum;

% Calculate the joint probabilities
% Example: P(C1,X=x) = num. samples in corresponding box ) / num. all samples
joint_probs = data(1:2,:)/total_sum;

% Calculate the conditional probabilities
% Example: P(X=x|C1) = num. samples in corresponding box / num. of samples in C1-row
% Another way to calculate it is to divide the joint probability by the prior probability
conditionals = joint_probs ./ repmat(priors',1,size(joint_probs,2));

% Calculate the posterior probabilities
% P(C1|X=x) = P(X=x|C1) P(C1)/ P(X=x)
posteriors = ( conditionals .* repmat(priors',1,size(joint_probs,2)) ) ./ repmat(prob_x,2,1);

% Plot the classes histogram
figure, hold on
	minx = min(data(3,:));
	maxx = max(data(3,:));
	miny = min(min(data(1:2,:)));
	maxy = max(max(data(1:2,:)));
	axis([minx maxx miny maxy]);
	stairs(data(3,:), data(1,:), '-');
	stairs(data(3,:), data(2,:), '-.');
	xlab = xlabel('$$\overline{x}_{l}$$','FontSize',18,'FontWeight','bold');
	ylab = ylabel('Number of samples','FontSize',18,'FontWeight','bold');
	hleg1 = legend('C$$_{1}$$','C$$_{2}$$');
	set(hleg1,'Interpreter','latex');
	set(xlab,'Interpreter','latex');
	set(ylab,'Interpreter','latex');
hold off

% Plot the posterior probabilities histogram
figure, hold on
	stairs(data(3,:), posteriors(1,:), '-');
	stairs(data(3,:), posteriors(2,:), '-.');
	xlab = xlabel('$$\overline{x}_{l}$$','FontSize',18,'FontWeight','bold');
	ylab = ylabel('Posterior probability','FontSize',18,'FontWeight','bold');
	hleg1 = legend('P(C$$_{1}$$ $$\|$$ $$\overline{x}_{l}$$)','P(C$$_{2}$$ $$\|$$ $$\overline{x}_{l}$$)');
	set(hleg1,'Interpreter','latex');
	set(xlab,'Interpreter','latex');
	set(ylab,'Interpreter','latex');
hold off

% Calculate decision boundary
datatmp = data(1:2,:);
rowtmp = fliplr(datatmp(1,:));
datatmp(1,:) = [ 0 rowtmp(1:end-1) ];
datatmp = cumsum(datatmp,2);
datatmp(1,:) = fliplr(datatmp(1,:));
misclassified = sum(datatmp);

% Misclassifications by class at each decision boundary
misclassified

% Find optimal decision boundary
[min index] = min(sum(misclassified));
index = index + 1;

% Plot the posterior probabilities histogram with the decision boundary
figure, hold on
	stairs(data(3,:), posteriors(1,:), '-');
	stairs(data(3,:), posteriors(2,:), '-.');
	
	y = 0:0.001:1;	
	plot(index, y);
	
    tit = title('Decision boundary', 'FontSize',20,'FontWeight','bold');
	xlab = xlabel('$$\overline{x}_{l}$$','FontSize',18,'FontWeight','bold');
	ylab = ylabel('Posterior probability','FontSize',18,'FontWeight','bold');
	hleg1 = legend('P(C$$_{1}$$ $$\|$$ $$\overline{x}_{l}$$)','P(C$$_{2}$$ $$\|$$ $$\overline{x}_{l}$$)');
	set(tit,'Interpreter','latex');
    set(hleg1,'Interpreter','latex');
	set(xlab,'Interpreter','latex');
	set(ylab,'Interpreter','latex');
hold off
