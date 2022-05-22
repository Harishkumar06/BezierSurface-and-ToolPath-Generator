function BezSurfPlot(pts,smoothness,color)
%smoothness = 0.02;
BezX = [];
BezY = [];
BezZ = [];
i=1;
for t=0:smoothness:1
    BezX(i) = 1* t^3 * pts(4,1) * (1-t)^0 + 3* t^2 * pts(3,1) * (1-t)^1 + 3* t^1 * pts(2,1) * (1-t)^2 + 1* t^0 * pts(1,1) * (1-t)^3;
    BezY(i) = 1* t^3 * pts(4,2) * (1-t)^0 + 3* t^2 * pts(3,2) * (1-t)^1 + 3* t^1 * pts(2,2) * (1-t)^2 + 1* t^0 * pts(1,2) * (1-t)^3;
    BezZ(i) = 1* t^3 * pts(4,3) * (1-t)^0 + 3* t^2 * pts(3,3) * (1-t)^1 + 3* t^1 * pts(2,3) * (1-t)^2 + 1* t^0 * pts(1,3) * (1-t)^3;

    i = i + 1;
end

plot3(BezX,BezY,BezZ,'color',color);
grid on
hold on
    
%{
     BezX(i) = 1* t^3 * pts(4,1) * (1-t)^0 +
%               3* t^2 * pts(3,1) * (1-t)^1 + 
%               3* t^1 * pts(2,1) * (1-t)^2 + 
%               1* t^0 * pts(1,1) * (1-t)^3;
%     BezY(i) = 1* t^3 * pts(4,2) + t^2 * pts(3,2) * (1-t)^1 + t * pts(2,2) * (1-t)^2 + pts(1,2) * (1-t)^3;
%     BezZ(i) = 1* t^3 * pts(4,3) + t^2 * pts(3,3) * (1-t)^1 + t * pts(2,3) * (1-t)^2 + pts(1,3) * (1-t)^3;
%}