clear;close;home

%load the data from "MainForTwoDTwoF_firstApproach"

data = zeros(10,10,100);

r,c,d = size(data);

TensorDepth = zeros(r,c,d);
TensorRow = zeros(r,c,d);

for i = 1:d
    TensorDepth(:,:,i) = funn(data(:,:,i));
end

for i = 1:r
    TensorRow(i,:,:) = funn(data(i,:,:));
end