function flag = findIT(quantity,RAdd,CAdd,Data,flag)
[row,colomn] = size(Data);

if RAdd==0||CAdd==0||RAdd>row||CAdd>colomn %don'e exceed the matrix idx
    return
end

if flag(RAdd,CAdd)==1 %it prevents it from infinit loop
    return
end

if quantity==Data(RAdd,CAdd) %if it's not the same
    flag(RAdd,CAdd)=1;
else
    return
end

flag = findIT(quantity,RAdd-1,CAdd,Data,flag);
flag = findIT(quantity,RAdd+1,CAdd,Data,flag);
flag = findIT(quantity,RAdd,CAdd-1,Data,flag);
flag = findIT(quantity,RAdd,CAdd+1,Data,flag);
