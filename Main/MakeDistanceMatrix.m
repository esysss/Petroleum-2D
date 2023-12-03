function [matrix] = MakeDistanceMatrix(Data,Direction)
A = size(Data);
if Direction == 'x'
    for j = 1:A(1)
        for i = 1:A(2)-1
            matrix(j,i)=abs(Data(j,i)-Data(j,i+1));%this data minus next data , moves in rows
        end
    end
else
    for j = 1:A(2)
        for i = 1:A(1)-1
            matrix(i,j)=abs(Data(i,j)-Data(i+1,j));%this data minus next data , moves in colomns
        end
    end
end