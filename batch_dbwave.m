%%%小波变换，保存处理后的数据，去噪
%%%批量处理
closefile_path = '.\btcclose\btcdata\';
closeapproximate_path = '.\btcclose\btcdataapproximate2\';

closelist = dir(strcat(closefile_path,'*.mat'));
closeapproximatelist = dir(strcat(closeapproximate_path,'*.mat'));

closenum = length(closelist);

if closenum > 0
    for j =1:closenum
        filename = closelist(j).name;
        temp = importdata(strcat(closefile_path,filename));
        
        %%%小波变换，使用db5小波，level7
        [C,L] = wavedec(temp,7,'db5');
        a7 = wrcoef('a',C,L,'db5',7);
        
        %%%保存approximate7
        j = find('.'==filename);
        %去除文件后缀，提取单纯的文件名
        imname = filename(1:j-1);
        savename = strcat(closeapproximate_path,imname,'_7.mat');
        save (savename,'a7');
        clear temp;
    end
end

%subplot(411);plot(a1);
%subplot(412);plot(a7);