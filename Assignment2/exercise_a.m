data = [ 2 5 7 6 4 2 1 0 0; 0 0 0 1 3 3 5 4 2; 1 2 3 4 5 6 7 8 9 ];

C1 = data(1,:);
C2 = data(2,:);
xl = data(3,:);

C1_samples = sum(C1);
C2_samples = sum(C2);
total_samples = C1_samples + C2_samples;

joint_prob_C1 = []

for i=1:numel(xl),
	prob = C1(i)/total_samples;
	joint_prob_C1 = [ joint_prob_C1 prob]
end

joint_prob_C2 = []

for i=1:numel(xl),
	prob = C2(i)/total_samples;
	joint_prob_C2 = [ joint_prob_C2 prob]
end

cond_prob_C1 = [];

for i=1:numel(xl),
	prob = C1(i)/C1_samples;
	cond_prob_C1 = [ cond_prob_C1 prob];
end

cond_prob_C2 = [];

for i=1:numel(xl),
	prob = C2(i)/C2_samples;
	cond_prob_C2 = [ cond_prob_C2 prob];
end

