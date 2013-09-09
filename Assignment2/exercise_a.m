data = [ 2 5 7 6 4 2 1 0 0; 0 0 0 1 3 3 5 4 2; 1 2 3 4 5 6 7 8 9 ];

C1 = data(1,:);
C2 = data(2,:);
xl = data(3,:);

C1_samples = sum(C1);
C2_samples = sum(C2);
total_samples = C1_samples + C2_samples;

joint_prob_C1 = []

for i=1:numel(xl),
	joint_prob_C1 = [ joint_prob_C1 C1(i)/total_samples]
end

joint_prob_C2 = []

for i=1:numel(xl),
	joint_prob_C2 = [ joint_prob_C2 C2(i)/total_samples]
end