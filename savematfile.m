% ������txt�ļ���������Ϊmat�ļ�

fileFolder=fullfile('C:\Users\venucia\Documents\goshare\btc\btcsrc\');%�ļ�����plane
dirOutput=dir(fullfile(fileFolder,'*.txt'));%������ڲ�ͬ���͵��ļ����á�*����ȡ���У������ȡ�ض������ļ���'.'�����ļ����ͣ������á�.jpg��

num = length(dirOutput);

for i=1:num
    fprintf('%s\n',dirOutput(i).name);
    temp = load(strcat('C:\Users\venucia\Documents\goshare\btc\btcsrc\',dirOutput(i).name));
    %Ѱ�Һ�׺��ǰ��ı�־��.��
    j = find('.'==dirOutput(i).name);
    %ȥ���ļ���׺����ȡ�������ļ���
    imname = dirOutput(i).name(1:j-1);
    savename = strcat('C:\Users\venucia\Documents\goshare\btc\btcclose\btcdata\',imname,'.mat');
    save (savename,'temp');
    clear temp;

end


