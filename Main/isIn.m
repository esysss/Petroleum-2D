function isIT = isIn(component,data)
[~,len]=size(data);
isIT = false;
for i = 1:len
    if data(:,i)==component
        isIT = true;
    end
end