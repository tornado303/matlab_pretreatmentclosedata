%%%С���任�����洦�������ݣ�ȥ��
%%%��������
closefile_path = '.\btcclose\btcdata\';
closeapproximate_path = '.\btcclose\btcdataapproximate2\';

closelist = dir(strcat(closefile_path,'*.mat'));
closeapproximatelist = dir(strcat(closeapproximate_path,'*.mat'));

closenum = length(closelist);

if closenum > 0
    for j =1:closenum
        filename = closelist(j).name;
        temp = importdata(strcat(closefile_path,filename));
        
        %%%С���任��ʹ��db5С����level7
        [C,L] = wavedec(temp,7,'db5');
        a7 = wrcoef('a',C,L,'db5',7);
        
        %%%����approximate7
        j = find('.'==filename);
        %ȥ���ļ���׺����ȡ�������ļ���
        imname = filename(1:j-1);
        savename = strcat(closeapproximate_path,imname,'_7.mat');
        save (savename,'a7');
        clear temp;
    end
end

%subplot(411);plot(a1);
%subplot(412);plot(a7);