close all
clear
format long
home

NUMBER_OF_PROPERTIES = 2;
tic;

Data = load('E:\Data\Test1.txt');

% Data = load('E:\Data\permgrid.txt');
%Data = load('E:\Data\phigrid.txt');

% Data = reshape(DATA,30,30);
% Data = reshape(DATA,70,70);
Data1 = Data;

[col,row] = size(Data);
% load('LAMBDA.mat')


%%%%%%%%%%%%%%%%%%%%%%%% it calculate the lambdas
        for i = 1:col
            XDirection(i,:) = oneDoneF(Data(i,:));
        end

        for i = 1:row
            YDirection(:,i) = oneDoneF(Data(:,i)');
        end
        
LANDA = [mean(XDirection),mean(YDirection)];
%%%%%%%%%%%%%%%%%%%%%%%%
Nlimit = 10;% the first condition
%%%%%%%%%%%%%%%%%%%%%%%%

xDirectionForbiden = [];
xDirectionForbidenCounter = 0;
yDirectionForbiden = [];
yDirectionForbidenCounter = 0;

numberOfBlocks = howManyBlocks(Data);
numberOfBlocksLimit = 30;%this is another one of the conditions!!!

finishLine = numel(Data);
finishLineCounter = 0;

while(finishLineCounter<finishLine && numberOfBlocks > numberOfBlocksLimit)
    
    [Xsorted,Ysorted,Xdistance,Ydistance] = distanceCalculator(Data);
    
    xsortcounter = 1;
    ysortcounter = 1;
    
    while(true)
        if isempty(Ysorted) && isempty(Xsorted)
            break
        elseif isempty(Xsorted)
            [RAdd,CAdd] = find(Ydistance==Ysorted(ysortcounter));
            DiretionMark = 'y';
        elseif isempty(Ysorted)
            [RAdd,CAdd] = find(Xdistance==Xsorted(xsortcounter));
            DiretionMark = 'x';
        elseif Xsorted(xsortcounter) < Ysorted(ysortcounter)
            [RAdd,CAdd] = find(Xdistance==Xsorted(xsortcounter));
            DiretionMark = 'x';
        else
            [RAdd,CAdd] = find(Ydistance==Ysorted(ysortcounter));
            DiretionMark = 'y';
        end
        
        nestedLoopBreak = false;
        
        for i = 1:length(RAdd)
            if DiretionMark == 'y'
                if ~isIn([RAdd(i);CAdd(i)],yDirectionForbiden)
                    nestedLoopBreak = true;
                break
                end
            else
                if ~isIn([RAdd(i);CAdd(i)],xDirectionForbiden)
                    nestedLoopBreak = true;
                break
                end
            end
        end 
        
        if DiretionMark == 'y'
            ysortcounter = ysortcounter+1;
        else
            xsortcounter = xsortcounter+1;
        end
        
        if nestedLoopBreak
            break
        end
    end
    if DiretionMark == 'y'
        lambda = YDirection(CAdd(i));
        ChoosenItem = Data(RAdd(i)+1,CAdd(i));
    else
        lambda = XDirection(RAdd(i));
        ChoosenItem = Data(RAdd(i),CAdd(i)+1);
    end

    if abs(Data(RAdd(i),CAdd(i))-ChoosenItem)<=lambda%this is the third condition....
        finishLineCounter = 0;
        [Data,accept] = FindMergedBlocks(RAdd(i),CAdd(i),Data,DiretionMark,Nlimit);
        if ~accept
            if DiretionMark == 'y'
                yDirectionForbidenCounter = yDirectionForbidenCounter+1;
                yDirectionForbiden(:,yDirectionForbidenCounter)=[RAdd(i);CAdd(i)];
            else
                xDirectionForbidenCounter = xDirectionForbidenCounter+1;
                xDirectionForbiden(:,xDirectionForbidenCounter)=[RAdd(i);CAdd(i)];
            end
        end
    else
        finishLineCounter = finishLineCounter+1;
    end
    
    numberOfBlocks = howManyBlocks(Data);
end
SSE = Data1 - Data;
SSE = SSE.^2;
SSE = sum(sum(SSE))
N = length(unique(Data))
toc;
figure(1)
imagesc(Data);colormap(gray);colorbar;
figure(2)
imagesc(Data1);colormap(gray);colorbar;

% LetsVisualIt_ultemate(Data)
% LetsVisualItSoBetter (Data)