% Resume training from a previously saved network
% https://www.mathworks.com/help/deeplearning/ug/resume-training-from-a-checkpoint-network.html
clear
close all
clc

%% Text data sample for training
textSample

%% Load checkpoint network and resume training
load('net_checkpoint__499__2019_03_21__23_25_40.mat', 'net')
options = trainingOptions('adam', ...
    'MaxEpochs', 300, ...
    'InitialLearnRate', 0.01, ...
    'MiniBatchSize', 32, ...
    'Shuffle', 'never', ...
    'Plots', 'training-progress', ...
    'Verbose', false,...
    'CheckpointPath', pwd);
net2 = trainNetwork(ds, net.Layers, options);

%% Save trained network to trained_network_sample folder
fname = fullfile(fileparts(pwd), 'trained_network_sample',...
    [novelTitle,'_LSTMnet']);
save(fname, '-append', 'net2')
