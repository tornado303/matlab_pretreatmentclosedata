% 批量读txt文件，并保存为mat文件

fileFolder=fullfile('C:\Users\venucia\Documents\goshare\btc\btcsrc\');%文件夹名plane
dirOutput=dir(fullfile(fileFolder,'*.txt'));%如果存在不同类型的文件，用‘*’读取所有，如果读取特定类型文件，'.'加上文件类型，例如用‘.jpg’

num = length(dirOutput);

for i=1:num
    fprintf('%s\n',dirOutput(i).name);
    temp = load(strcat('C:\Users\venucia\Documents\goshare\btc\btcsrc\',dirOutput(i).name));
    %寻找后缀名前面的标志‘.’
    j = find('.'==dirOutput(i).name);
    %去除文件后缀，提取单纯的文件名
    imname = dirOutput(i).name(1:j-1);
    savename = strcat('C:\Users\venucia\Documents\goshare\btc\btcclose\btcdata\',imname,'.mat');
    save (savename,'temp');
    clear temp;

end


