%{
    获取文件夹内所有mat文件
    btc_close文件和btc_close_approximate
%}
% back 为该极值点前几个数据来判断极值点
lookback = 60;
cost = 10;
closefile_path = '.\btcclose\btcdata\';
closeapproximate_path = '.\btcclose\btcdataapproximate2\';
traindata_path = '.\btcclose\traindata\';

closelist = dir(strcat(closefile_path,'*.mat'));
closeapproximatelist = dir(strcat(closeapproximate_path,'*.mat'));

closenum = length(closeapproximatelist);
 trainoutall = [];
if closenum > 0
    for j =1:closenum
        filename = closelist(j).name;
        approximatefilename = closeapproximatelist(j).name;
        
        if strncmp(filename,approximatefilename,12) == 0
            fprintf("error !");
            break;
        end
        
        btcclose = importdata(strcat(closefile_path,filename));
        btccloseapproximate = importdata(strcat(closeapproximate_path,approximatefilename));
     
        [pks,locs] = findpeaks(btccloseapproximate); 
        [minpks,minlocs] = findpeaks(-btccloseapproximate);
  
        maxvalue = btcclose(locs);
        minvalue = btcclose(minlocs);

        train_max = [maxvalue';locs';ones(1,length(locs))];
        train_min = [minvalue';minlocs';zeros(1,length(minlocs))];

        train_all = [train_max,train_min];
        train = sortrows(train_all',2);
        
 
        for i = 1 : size(train(:,1,1))

            if(i >= size(train(:,1,1)))
                    break;     
            end
            temp = train(i,1,1);
            while (abs(train(i+1,1,1) - temp) < cost)    

              train(i+1,:,:) = [];
             if(i+1 >size(train(:,1,1)))
                    break;     
              end

            end
            i=i+1;
        end

      
        trainout = [];
        for i = 1 : size(train(:,2))

            temp =  train(i,2);
            if (temp>back)
                Atemp = btcclose(temp-back:temp-1);
                traintemp = [ Atemp',train(i,3)];
                trainout = [trainout;traintemp];
                i=i+1;
            end
        end
        size(train(:,2))
        suffix = '.csv';
        
        %savename =  strcat(traindata_path,filename,suffix);
        %csvwrite(savename,trainout);
        trainoutall = [trainoutall;trainout];
        %fprintf('%s,%s\n',strcat(closefile_path,filename),strcat(closeapproximate_path,approximatefilename));
    end
    savename = strcat(traindata_path,'traindata_',num2str(lookback),suffix);
    csvwrite(savename,trainoutall);
end


%{
load('.\btcclose\btc_20180727_close_7.mat')
load('.\btcclose\btc_20180727_close.mat')

btc_close = btc_20180727_close;
btc_close_approximate = btc_20180727_close_7;

[pks,locs] = findpeaks(btc_close_approximate); 
[minpks,minlocs] = findpeaks(-btc_close_approximate);
  
maxvalue = btc_close(locs);
minvalue = btc_close(minlocs);

%}

% plot(data);
% hold on 
% plot(minlocs,-minpks,'o',locs,pks,'*');   
% plot(minlocs,minvalue,'o',locs,maxvalue,'*');  

% 添加极值标签，极大值为1，极小值为-1
%{
train_max = [maxvalue';locs;ones(1,length(locs))];
train_min = [minvalue';minlocs;-ones(1,length(minlocs))];

train_all = [train_max,train_min];
train = sortrows(train_all',2);
%}
%size(train(:,1,1))

%{

cost = 0;
for i = 1 : size(train(:,1,1))
    
    if(i >= size(train(:,1,1)))
            break;     
    end
    temp = train(i,1,1);
    while (abs(train(i+1,1,1) - temp) < cost)    
    
      train(i+1,:,:) = [];
     if(i+1 >size(train(:,1,1)))
            break;     
      end
     
    end
    i=i+1;
end


back = 20;
trainout = [];
for i = 1 : size(train(:,2))
    
    temp =  train(i,2);
    if (temp>20)
        Atemp = btc_close(temp-back:temp-1);
        traintemp = [ Atemp',train(i,3)];
        trainout = [trainout;traintemp];
        i=i+1;
    end
end
size(train(:,2))
suffix = '.csv';
filename = ['btc_20180727_close1',suffix];
csvwrite(filename,trainout)

%}

%{
alldiffvalue = allvalue;
cost = 1000;
for  i=1:(max(size(alldiffvalue)))
    temp = alldiffvalue(i);
    while(abs(alldiffvalue(i+1) - temp) < cost)
    alldiffvalue(i+1)=[];
    size(alldiffvalue);
    end
    i=i+1;
end
%}