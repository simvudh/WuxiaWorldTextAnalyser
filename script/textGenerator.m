% Generate new text by trained LSTM network
clear
close all
clc

%% Text data sample
textSample

%% Trained LSTM network
fname = fullfile(fileparts(pwd), 'trained_network_sample',...
    [novelTitle,'_LSTMnet']);
load(fname)

%% Generate new text
initialWords = docfun(@(words) words(1), documents);
firstWord = string(datasample(initialWords,1));
generatedText = firstWord;
enc = ds.Encoding;
wordIndex = word2ind(enc, firstWord);
vocabulary = string(net.Layers(end).Classes);
maxLength = 500;
while strlength(generatedText) < maxLength
    % Predict the next word scores
    [net,wordScores] = predictAndUpdateState(net, wordIndex,...
        'ExecutionEnvironment', 'cpu');
    
    % Sample the next word
    newWord = datasample(vocabulary,1, 'Weights',wordScores);
    
    % Stop predicting at the end of text
    if newWord == "EndOfText"
        break
    end
    
    % Add the word to the generated text
    generatedText = generatedText + " " + newWord;
    
    % Find the word index for the next input
    wordIndex = word2ind(enc,newWord);
end
punctuationCharacters = ["." "," "’" ")" ":" "?" "!"];
generatedText = replace(generatedText," " + punctuationCharacters,...
    punctuationCharacters);
punctuationCharacters = ["(" "‘"];
generatedText = replace(generatedText,punctuationCharacters + " ",...
    punctuationCharacters);
disp(generatedText)

net = resetState(net);
