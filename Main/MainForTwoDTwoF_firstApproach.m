clear,close,home

% m = load('Test1.txt');
% mm = load('Test2.txt');

m = load('phigrid.txt');
mm = load('permgrid.txt');

% data1 = MainForTwoDNew1(m); %you have to give the data 
% data2 = MainForTwoDNew2(mm); %you have to give the data
load('datas.mat')
% data1 = data1; %you have to give the data 
% data2 = data2; %you have to give the data 

%data2 = MainForTwoDNew2(mm); %you have to give the data

%  save datas
% load('datas.mat')
savedData1 = data1;
savedData2 = data2;

[row1,col1]=size(data1);
[row2,col2]=size(data2);

if row1~=row2 || col1~=col2
    disp('the size of the two Datas are not the same')
    return
end

flagForFirst = zeros(row1,col1);
flagForSecond = zeros(row2,col2);

uni1 = unique(data1);
uni2 = unique(data2);

for i = 1:length(uni1)
    flagForFirst(find(data1==uni1(i)))= i;
end

for i = 1:length(uni2)
    flagForSecond(find(data2==uni2(i)))= i;
end

%Merged data1 for data2 : 
for i = 1:length(uni1)
    idx = find(flagForFirst==i);
    numberOfMergedBlocks = length(idx);
    %mergedData = sum(data2(idx))/numberOfMergedBlocks;
    mergedData = sum(mm(idx))/numberOfMergedBlocks;

    data2(idx) = mergedData;
end


%Merged data2 for data1 : 
for i = 1:length(uni2)
    idx = find(flagForSecond==i);
    numberOfMergedBlocks = length(idx);
    %mergedData = sum(data1(idx))/numberOfMergedBlocks;
    mergedData = sum(m(idx))/numberOfMergedBlocks;

    data1(idx) = mergedData;
end

SSE1 = sum(sum((m-savedData1).^2));
SSE12 = sum(sum((m-data1).^2));

N1 = howManyBlocks(savedData1);
N2 = howManyBlocks(savedData2);
N12 = howManyBlocks(data1);
N21 = howManyBlocks(data2);

SSE2 = sum(sum((mm-savedData2).^2));
SSE21 = sum(sum((mm-data2).^2));


if SSE12/SSE1>SSE21/SSE2
    disp('the first data is better !!!')
elseif SSE12/SSE1<SSE21/SSE2
    disp('the second data is better!!!')
else
    disp('both are the same')
end

% figure
LetsVisualIt_ultemate(savedData1,'first data')
title('first data')

% figure
LetsVisualIt_ultemate(savedData2,'second data')
title('second data')

% figure
LetsVisualIt_ultemate(data1,'data1 over data2')
title('data1 over data2')

% figure
LetsVisualIt_ultemate(data2,'data2 over data1')
title('data2 over data1')
