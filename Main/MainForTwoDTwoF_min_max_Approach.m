clear,close,home
tic;
MinOrMax = 'max';

% m = load('Test1.txt');
% mm = load('Test2.txt');

m = load('phigrid.txt');
mm = load('permgrid.txt');

% data1 = MainForTwoDNew1(m); %you have to give the data 
% data2 = MainForTwoDNew2(mm); %you have to give the data

%save oneproperty_upscaling data1 data2

load('oneproperty_upscaling.mat')
data1 = data1;
data2 = data2;

originalData1 = m;
originalData2 = mm;

% data1 = MainForTwoD(load('Test1.txt')); %you have to give the data 
% data2 = MainForTwoD(load('Test2.txt')); %you have to give the data

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

totalFlag = zeros(row1,col1);
blockCounter = 0;
while(123==123)
    idx = find(totalFlag==0);
    
    if isempty(idx)
        break
    end
    
    contentOfFlaf1 = flagForFirst(idx(1));
    contentOfFlag2 = flagForSecond(idx(1));
    
    idxForFlag1 = find(flagForFirst==contentOfFlaf1);
    idxForFlag2 = find(flagForSecond==contentOfFlag2);
    
    if strcmp(MinOrMax,'min')
        intersc = intersect(idxForFlag1,idxForFlag2);
    elseif strcmp(MinOrMax,'max')
        intersc = union(idxForFlag1,idxForFlag2);
    else
        disp('you have to choose between min or max')
        return
    end
    
    blockCounter = blockCounter+1;
    totalFlag(intersc) = blockCounter;
    
    flagForFirst(intersc) = 0;
    flagForSecond(intersc) = 0;
end


%apply the pattern on both datas
uniT = unique(totalFlag);

for a = uniT'
    idx = find(totalFlag == a);
    len = length(idx);
    m(idx) = sum(m(idx))/len;
    mm(idx) = sum(mm(idx))/len;
end
LetsVisualIt_ultemate(m,'data1')
N1 = howManyBlocks(m);
LetsVisualIt_ultemate(mm,'data2')
N2 = howManyBlocks(mm);

save towproperty_upscalingmax m mm data1 data2 originalData1 originalData2

sse1 = sum(sum((originalData1-m).^2));
sse2 = sum(sum((originalData2-mm).^2));
sse11 = sum(sum((originalData1-data1).^2));
sse22 = sum(sum((originalData2-data2).^2));
toc;