% Visualize text data in word cloud chart
clear
close all
clc

%% Text data sample
textSample

%% Visualize text data in word cloud
textData = replace(textData, {'’s'}, '');
figure('units', 'normalized', 'position', [.1 .1 .5 .5]);
wordcloud(textData)

%% Save figure to image folder
fname = fullfile(fileparts(pwd), 'images', novelTitle);
saveas(gcf, [fname, '.jpg'])
