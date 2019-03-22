% Text data sample for training and generate new text
%% Novel title for analysis
novelTitle = 'a_will_eternal';
%% Load text data
fname = fullfile(fileparts(pwd), 'text_sample', [novelTitle, '.mat']);
load(fname);
textData = chText;
%% Prepare data for training
documents = tokenizedDocument(textData);
ds = documentGenerationDatastore(documents);
ds = sort(ds);
