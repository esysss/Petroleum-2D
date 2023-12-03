function Data = MainForTwoD(DATA)
Data = DATA;

[col,row] = size(Data);
% load('LAMBDA.mat')


%%%%%%%%%%%%%%%%%%%%%%%% it calculate the lambdas
       % for i = 1:col
       %     XDirection(i,:) = oneDoneF(Data(i,:));
      %  end

      %  for i = 1:row
        %    YDirection(:,i) = oneDoneF(Data(:,i)');
      %  end

%%%%%%%%%%%%%%%%%%%%%%%%
Nlimit = 30;% the first condition
%%%%%%%%%%%%%%%%%%%%%%%%
load('Xs')

xDirectionForbiden = [];
xDirectionForbidenCounter = 0;
yDirectionForbiden = [];
yDirectionForbidenCounter = 0;

numberOfBlocks = howManyBlocks(Data);
numberOfBlocksLimit = 30;%this is another one of the conditions!!!

finishLine = numberOfBlocks;
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
SSE = DATA - Data;
SSE = SSE.^2;
SSE = sum(sum(SSE));
N = length(unique(Data));

LetsVisualIt_ultemate(Data)