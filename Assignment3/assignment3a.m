function result = assignment3a()
    global num_hidden;
    global num_iterations;
    load('line.mat');
    result = zeros(31,10);
    for h = 1:size(result,1),
        num_hidden = h;
        for i = 1:size(result,2),
            num_iterations = 100;%i*10;
            result(num_hidden,i) = crossvalidation(5,@create_mlp_and_test,x,t);
        end
    end
end