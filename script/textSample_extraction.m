% Extract text data from light novel in WuxiaWorld
% All text and data belong to WuxiaWorld (https://www.wuxiaworld.com/)
clear
close all
clc

%% Novel informations list
novelInfo = jsondecode(fileread('novelInfo.json'));
% novelInfo = webread('https://simvudh.github.io/WuxiaWorldTextAnalyser/script/novelInfo.json');

%% Novel to extract text
novel = 'AWE';
novelTitle = novelInfo.(novel).Title;		% title of novel
urlTemp = novelInfo.(novel).urlTemp;		% first chapter link
endRef = novelInfo.(novel).endRef;			% end of chapter note
urlRef = novelInfo.(novel).urlRef;			% link element reference

%% Extract chapter title and text data
chTitle = [];
chIndex = [];
chText = [];
next = true;
tic
while next
    % read chapter HTML
    url = strcat('https://www.wuxiaworld.com', urlTemp);
    HTML = webread(url);
    HTML = htmlTree(HTML);
    % link to next chapter
    urlTemp = findElement(HTML, 'link');
    urlTemp = string(urlTemp);
    urlTemp = urlTemp(contains(urlTemp, '"next"'));
    next = ~isempty(urlTemp);
    if ~next    % roll back one chpater if no next link
        chTitle = chTitle(1:end-length(titleTemp));
        chText = chText(1:end-length(textTemp));
        break
    end
    urlTemp = replace(urlTemp, urlRef, '');
    % chapter title
    titleTemp = findElement(HTML, 'title');
    titleTemp = extractHTMLText(titleTemp);
    chTitle = [chTitle; titleTemp]; %#ok<*AGROW>
    % chapter text
    chIndex = [chIndex; length(chText)+1];
    textTemp = findElement(HTML, 'p');
    textTemp = extractHTMLText(textTemp);
    ind = find(textTemp == endRef);
    textTemp = textTemp(1:ind(1)-2);
    textTemp(textTemp == '') = [];
    textTemp(textTemp == '...') = [];
    textTemp(~cellfun('isempty', regexp(textTemp, '^\d[.]\s\w*'))) = [];
    chText = [chText; textTemp];
    toc
end

%% Save text to text_sample folder
fname = fullfile(fileparts(pwd), 'text_sample', novelTitle);
varname = {'novelTitle', 'chTitle', 'chIndex', 'chText', 'url'};
save(fname, varname{:});
