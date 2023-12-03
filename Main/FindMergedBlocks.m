function [Data,acception,label] = FindMergedBlocks(RAdd,CAdd,Data,DiretionMark,Nlimit,label)%finds all blocks with same amount in the neighborhood
[row,colomn]=size(Data);
flag = zeros(row,colomn);
%calculate the first block
quantity = Data(RAdd,CAdd);
firstBlockLabel = label(RAdd,CAdd);
flag = findIT(quantity,RAdd,CAdd,Data,flag);

idxx = find(flag==1);

if length(idxx)>=Nlimit
    acception = false;
    return
end

%calculate the other block
if DiretionMark == 'x'
    %secondBlockLabel = label(RAdd,CAdd+1);
    quantity = Data(RAdd,CAdd+1);
    flag = findIT(quantity,RAdd,CAdd+1,Data,flag);
else
    %secondBlockLabel = label(RAdd+1,CAdd);
    quantity = Data(RAdd+1,CAdd);
    flag = findIT(quantity,RAdd+1,CAdd,Data,flag);
end

idx = find(flag==1);
if length(idx)<=Nlimit
    mergeNumber=(sum(Data(idx)))/(length(idx));
    Data(idx)=mergeNumber;
    acception = true;
    label(idx) = firstBlockLabel;
else
    acception = false;
end