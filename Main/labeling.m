function label = labeling(matrix)
[row,col] = size(matrix);
label = zeros(row,col);
flag = zeros(row,col);
labelCounter = 1;
for i = 1:row
    for j = 1:col
        if label(i,j)==0
             newFlag = findIT(matrix(i,j),i,j,matrix,flag);
             label(find(newFlag==1))=labelCounter;
             labelCounter = labelCounter+1;
        end
    end
end