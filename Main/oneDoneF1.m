function LAMBDA = oneDoneF1(data)
% data = [1 2 3 7 2 6 10 3 13 15];
% Maxlambda = 10;
% lambda_step = 1;
%data = load('D:\Data2\SP-6.txt');
% data = load('E:\Data\Basic.txt');
%data=(data(:,6))';
Maxlambda = (max(data)-min(data))/2;
sdata=sort(data);
for j = 2:length(data)
    if sdata(1)~=sdata(j)
        break
    end
end
lambda_step = (sdata(j)-sdata(1))/10;%we chanaged it
NumOfData = length(data);
% counter1 = 1;
% counter2 = 2;
N=NumOfData;
SSE = zeros(1,NumOfData);
FirstSSE=SSE;
result = zeros(3,(round(Maxlambda/lambda_step)));
ResultCounter = 0;
FirstData = data;
ccounter=round(lambda_step\Maxlambda);
for lambda = 0:lambda_step:Maxlambda
    ResultCounter=ResultCounter+1;
    counter1 = 1;
    counter2 = 1;
    blockCounter=0;%THIS
     while(true)
        blockCounter=blockCounter+1;%THIS
        while(true)
            counter2=counter2+1;
             if (counter1>N || counter2>N)
                break
             end
             if (abs((data(counter2)-data(counter2-1)))>lambda)
               break
             end
        end
        nsize = counter2-counter1;
        if (nsize>1)
            TempData = data(counter1:counter2-1);
            NewData=sum(TempData)/nsize;
            AnotherNnewdata=ones(1,nsize);% i just added this
            NewData=NewData*AnotherNnewdata;% and this
            data = [data(1:counter1-1),NewData,data(counter2:end)];
            newSSE=0;
            for s = counter1:counter2-1
                 newSSE  = newSSE +(FirstData(s)-NewData(1))^2;
            end
            %newSSE=newSSE/nsize;\
            newSSE=ones(1,nsize)*newSSE;
            SSE = [SSE(1:counter1-1),newSSE,SSE(counter2:end)];
           % N = N-nsize+1;
            counter1=counter1+nsize;%changed this from 1
            counter2=counter1;
        else
            counter1=counter1+nsize;
        end
        
        if (counter1>N || counter2>N)
                 break
        end
     end
    %FinalData{ResultCounter} = data;  % after memory problem
    result(1,ResultCounter)=lambda;
    %[~,DS]=size(data);
    result(2,ResultCounter)=blockCounter;%THIS
    result(3,ResultCounter)=sum(SSE)/blockCounter;%THIS
    data=FirstData;
    SSE=FirstSSE;
    N=NumOfData;
    %FinalData;
    %lambda
   
end

for i = 1:1:length(result)-1
    SSEvar = result(3,i+1)-result(3,i);
    nvar = result(2,i+1)-result(2,i);
    SSEvar1(1,i) = SSEvar;
    nvar1 (1,i) = abs(nvar);
end

lambda = result(1,:);
n = result(2,:);
sse =  result(3,:);

%cut the Ns
[~,DS]=size(data);
limit = floor((DS*30)/100);% more that 30%
ChoosenNs = find(n>=limit);
if ChoosenNs == 1 % that means lambda=0
    temp1 = abs(limit-n(1));
    temp2 = abs(limit-n(2));
    if temp1>temp2
        OptimumLambda = lambda(2);
    else
        OptimumLambda = lambda(1);
    end
else
    OptimumLambda = lambda(ChoosenNs(end));
end
% end of cutting
% figure(1)
% subplot(2,1,1)
% plot(result(1,1:ccounter),result(3,1:ccounter));
% xlabel('Bandwidth','Fontname','Cambria');
% ylabel(' SSE','Fontname','Cambria');
% %title('Lambda Vs. SSE')
% subplot(2,1,2)
% plot(result(1,1:ccounter),result(2,1:ccounter));
% xlabel('Bandwidth','Fontname','Cambria');
% ylabel(' Number of Blocks','Fontname','Cambria');
% 
% figure (2)
% plot(result(2,1:ccounter),result(3,1:ccounter));
% xlabel('Number of Blocks','Fontname','Cambria');
% ylabel('SSE','Fontname','Cambria');
% figure (3)
% % plot(result(1,1:end),result(3,1:end),result(1,1:end),result(2,1:end));
% plotyy(result(1,1:ccounter),result(3,1:ccounter),result(1,1:ccounter),result(2,1:ccounter));
% % legend ('SSE', 'Number of Blocks');
% xlabel('Bandwidth','Fontname','Cambria');
% ylabel(' SSE','Fontname','Cambria');
% figure(5)
% plot(result(1,2:ccounter),SSEvar1(1,1:ccounter-1));
% xlabel('Bandwidth','Fontname','Cambria');
% ylabel(' SSE Variation','Fontname','Cambria');
% figure(6)
% plot(result(1,2:ccounter),nvar1(1,1:ccounter-1));
% xlabel('Bandwidth','Fontname','Cambria');
% ylabel(' N Variation','Fontname','Cambria');
SelectedLambda = OptimumLambda;
opt = round(SelectedLambda/ lambda_step);
%optt = FinalData{1,opt};  % for memory problem
% figure(4)
% subplot(2,1,1)
% plot(optt);
% xlabel('Data','Fontname','Cambria');
% ylabel(' Variability','Fontname','Cambria');
% legend('Upscaled Signal');
% subplot(2,1,2)
% plot(data);
% xlabel('Data','Fontname','Cambria');
% ylabel(' Variability','Fontname','Cambria');
% legend('Original Signal');

% DATA = optt;
%SSE = result(3,opt);
LAMBDA = OptimumLambda;
end




