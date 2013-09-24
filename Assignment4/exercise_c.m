% Load the generated data file
import_pics('data\pics.mat')

type = 'c';

L_fold = 10; % L-fold crossvalidation

[gam,sig2] = tunelssvm({pics,classGlass',type,[],[]},'simplex', 'crossvalidatelssvm',{L_fold,'misclass'});

[alpha,b] = trainlssvm({pics,classGlass',type,gam,sig2});

plotlssvm({pics,classGlass',type,gam,sig2},{alpha,b});