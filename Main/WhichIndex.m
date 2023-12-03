function [ output ] = WhichIndex( input )
[~,w]=size(input);
if w ==0
    output = 0;
    return
end
if w ==1
    output = 1;
    return
end
one = input(1);
for i = 2:w
    if input(i)~=one
        break;
    end
end
output = i-1;
end

