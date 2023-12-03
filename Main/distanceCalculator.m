function [Xsorted,Ysorted,Xdistance,Ydistance] = distanceCalculator(Data)
Xdistance = MakeDistanceMatrix(Data,'x');
Ydistance = MakeDistanceMatrix(Data,'y');

Xsorted = sort(Xdistance(:));
Ysorted = sort(Ydistance(:));

X = find(Xsorted ~=0);
Y = find(Ysorted ~=0);

Xsorted = Xsorted(X);
Ysorted = Ysorted(Y);