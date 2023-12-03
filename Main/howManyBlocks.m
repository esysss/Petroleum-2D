function numberOfBlocks = howManyBlocks(data)
[r,c] = size(data);
flag = zeros(r,c);
numberOfBlocks = 0;
while(~isempty(find(flag==0, 1)))
    [row,colomn]=find(flag==0);
    flag = findIT(data(row(1),colomn(1)),row(1),colomn(1),data,flag);
    numberOfBlocks = numberOfBlocks+1;
end