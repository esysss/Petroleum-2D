clear

tensor = zeros(10,10,9);
[r,c,d] = size(tensor);

for i=1:d
    tensor(:,:,i) = ones(10,10)*i;
end

otherTensor = zeros(c,d,r);

for i = 1:r
    otherTensor(:,:,i) = tensor(i,:,:);
end    