function [ counter ] = Ncounter( input )
[~,c]=size(input);
first = input(1);
counter = 1;
for i = 2 : c
    if first~=input(i)
        counter = counter+1;
        first = input(i);
    end
end

