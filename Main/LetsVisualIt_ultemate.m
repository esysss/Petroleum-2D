function [] = LetsVisualIt_ultemate(pic,titlee)
Limit = 256^3;%it works like a moderf*****
FinalPic1 = pic ;
FinalPic2 = pic ;
FinalPic3 = pic ;
uni = unique(pic);
len = length(uni);
step = floor(Limit/len);
if step==0
    disp('sorry i can not visual it  :-(')
    return
end

pixel = 0;
for i=1:len
    idx = find(pic==uni(i));
    pixel1 = mod(pixel,256);
    FinalPic1(idx) = pixel1;
    pixel1 = pixel;
    pixel1 = floor(pixel1/256);
    pixel2 = mod(pixel1,256);
    FinalPic2(idx) = pixel2;
    pixel2 = pixel1;
    pixel2 = floor(pixel2/256);
    pixel3 = mod(pixel2,256);
    FinalPic3(idx)=pixel3;
    
    pixel = pixel+step;
end
FinalPic(:,:,1)=FinalPic1;
FinalPic(:,:,2)=FinalPic2;
FinalPic(:,:,3)=FinalPic3;
figure
imshow(uint8(FinalPic))
title(titlee)