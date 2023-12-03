function Data = MainForTwoDNew1(DATA)
Data = DATA;

[col,row] = size(Data);
% load('LAMBDA.mat')


%%%%%%%%%%%%%%%%%%%%%%%% it calculate the lambdas
       for i = 1:col
           XDirection(i,:) = oneDoneF1(Data(i,:));
       end

       for i = 1:row
           YDirection(:,i) = oneDoneF1(Data(:,i)');
       end

%%%%%%%%%%%%%%%%%%%%%%%%
Nlimit = 30;% the first condition
%%%%%%%%%%%%%%%%%%%%%%%%
save porlambda XDirection YDirection

XDirection = mean(XDirection);
YDirection = mean(YDirection);

numberOfBlocks = howManyBlocks(Data);
numberOfBlocksLimit = 4000;%this is another one of the conditions!!!


[Xsorted,Ysorted,Xdistance,Ydistance] = distanceCalculator(Data);
    
xsortcounter = 1;
ysortcounter = 1;

if isempty(Xsorted)
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

i=1;

if DiretionMark == 'y'
    lambda = YDirection;
    ChoosenItem = Data(RAdd(i)+1,CAdd(i));
else
    lambda = XDirection;
    ChoosenItem = Data(RAdd(i),CAdd(i)+1);
end


%labeling
label = labeling(Data);

forbidenLabels = [];
forbidenCounter = 0;

while(abs(Data(RAdd(i),CAdd(i))-ChoosenItem)<=lambda && numberOfBlocks> numberOfBlocksLimit)
    choosenLabel = label(RAdd(i),CAdd(i));
    if size(find(forbidenLabels==choosenLabel),2)>0
        if size(RAdd,2)>i
            i=i+1;
        else
            if DiretionMark == 'y'
                ysortcounter = ysortcounter+1;
            else
                xsortcounter = xsortcounter+1;
            end
        end
    else
        [Data,accept,label] = FindMergedBlocks(RAdd(i),CAdd(i),Data,DiretionMark,Nlimit,label);
    end
    if ~accept
        forbidenCounter = forbidenCounter+1;
        forbidenLabels(forbidenCounter)=label(RAdd(i),CAdd(i));
    end
    
    [Xsorted,Ysorted,Xdistance,Ydistance] = distanceCalculator(Data);

    if isempty(Xsorted)
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
    
    if DiretionMark == 'y'
       lambda = YDirection;
       ChoosenItem = Data(RAdd(i)+1,CAdd(i));
    else
       lambda = XDirection;
       ChoosenItem = Data(RAdd(i),CAdd(i)+1);
    end

    numberOfBlocks = howManyBlocks(Data);
end

N = size(unique(labeling(label)));