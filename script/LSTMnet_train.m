% Train a deep learning LSTM network to generate text word-by-word
% https://www.mathworks.com/help/textanalytics/ug/word-by-word-text-generation-using-deep-learning.html
clear
close all
clc

%% Text data sample for training
textSample

%% Create and train LSTM network
inputSize = 1;
embeddingDimension = 100;
numWords = numel(ds.Encoding.Vocabulary);
numClasses = numWords + 1;
layers = [sequenceInputLayer(inputSize)
    wordEmbeddingLayer(embeddingDimension, numWords)
    lstmLayer(100)
    dropoutLayer(0.2)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];
checkpointPath = pwd;	% save checkpoint networks in durrent directory
options = trainingOptions('adam', ...
    'MaxEpochs', 300, ...
    'InitialLearnRate', 0.01, ...
    'MiniBatchSize', 32, ...
    'Shuffle', 'never', ...
    'Plots', 'training-progress', ...
    'Verbose', false,...
    'CheckpointPath', checkpointPath);
net = trainNetwork(ds, layers, options);

%% Save trained network to trained_network_sample folder
fname = fullfile(fileparts(pwd), 'trained_network_sample',...
    [novelTitle,'_LSTMnet']);
save(fname, 'net')
