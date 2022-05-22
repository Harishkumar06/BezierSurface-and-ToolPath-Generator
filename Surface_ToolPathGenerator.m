clear;
clc;

stock_height = 2.5;
R = 1.00;                   % toolTip_Radius
H = 0.01;                   % Scallop_height
E = 0.01;                   % chordal_error

stepForward = 2 * sqrt(R^2 - (R-E)^2);
stepOver = 2 * sqrt(R^2 - (R-H)^2);

curveSmoothness = 0.02;
surfSmoothness  = 0.02;
%% Defining Points

points_u = {
%     01, 5, randi([1,35]),      10, 5, randi([1,35]),     20, 5, randi([1,35]),     30, 5, randi([1,35]);
%     01,15, randi([1,35]),      10,15, randi([1,35]),     20,15, randi([1,35]),     30,15, randi([1,35]);
%     01,25, randi([1,35]),      10,25, randi([1,35]),     20,25, randi([1,35]),     30,25, randi([1,35]);
%     01,35, randi([1,35]),      10,35, randi([1,35]),     20,35, randi([1,35]),     30,35, randi([1,35]);
% };
%     randi([1,10]),randi([5,15]) , randi([1,35]),      randi([10,20]),randi([5,15]) , randi([1,35]),     randi([20,30]),randi([5,15]) , randi([1,35]),     randi([30,40]),randi([5,15]) , randi([1,35]);
%     randi([1,10]),randi([15,25]), randi([1,35]),      randi([10,20]),randi([15,25]), randi([1,35]),     randi([20,30]),randi([15,25]), randi([1,35]),     randi([30,40]),randi([15,25]), randi([1,35]);
%     randi([1,10]),randi([25,35]), randi([1,35]),      randi([10,20]),randi([25,35]), randi([1,35]),     randi([20,30]),randi([25,35]), randi([1,35]),     randi([30,40]),randi([25,35]), randi([1,35]);
%     randi([1,10]),randi([35,45]), randi([1,35]),      randi([10,20]),randi([35,45]), randi([1,35]),     randi([20,30]),randi([35,45]), randi([1,35]),     randi([30,40]),randi([35,45]), randi([1,35]);
% };

    01, 5,1,      10, 5,3,     20, 5,1,     30, 5, 1;
    01,15,2,      10,15,3,     20,15,2,     30,15, 2;
    01,25,3,      10,25,2,     20,25,1,     30,25, 2;
    01,35,2,      10,35,1,     20,35,2,     30,35, 1;
};

% Points Sent by chinmay
% { 
%           0,  0, 0,    12,  0, -5,    28, 1,  4,    40,  0, 1;
%          -5, 18, 5,    13, 17, -3,    29, 15, 3,    41, 18,-1;
%          -7, 32, 7,    14, 31, 10,    28, 28, 0,    44, 32, 5;
%           0, 50,-3,    12, 55,  5,    29, 45,-7,    41, 50, 0;
% };

points_u = cell2mat(points_u);
points_v = zeros(4,12);

for j = 0:3 
    for i = 0:3
        points_v(j+1,i*3+1) = points_u(i + 1 + 0 + 12*j);
        points_v(j+1,i*3+2) = points_u(i + 1 + 4 + 12*j);
        points_v(j+1,i*3+3) = points_u(i + 1 + 8 + 12*j);
    end
end

%% Getting the curves


u0 = BezierCurve(points_u(1:4,    1:3  ),curveSmoothness);    % 4x3
u1 = BezierCurve(points_u(1:4,    4:6  ),curveSmoothness);
u2 = BezierCurve(points_u(1:4,    7:9  ),curveSmoothness);
u3 = BezierCurve(points_u(1:4,    10:12),curveSmoothness);

v0 = BezierCurve(points_v(1:4,    1:3  ),curveSmoothness);    % 4x3
v1 = BezierCurve(points_v(1:4,    4:6  ),curveSmoothness);
v2 = BezierCurve(points_v(1:4,    7:9  ),curveSmoothness);
v3 = BezierCurve(points_v(1:4,    10:12),curveSmoothness);

%% Run to get the Bezier surface 

BezSurfPts_u=[];
BezSurfPts_v=[];

subplot(1,3,1)


n=length(u0);
for i=1:n
    BezSurfPts_u(1:4,(3*i-2):3*i)=[u0(i,:);u1(i,:);u2(i,:);u3(i,:)];
    BezSurfPts_v(1:4,(3*i-2):3*i)=[v0(i,:);v1(i,:);v2(i,:);v3(i,:)];
    
    BezSurfPlot(BezSurfPts_u(1:4,(3*i-2):3*i),surfSmoothness,'b');
    BezSurfPlot(BezSurfPts_v(1:4,(3*i-2):3*i),surfSmoothness,'b');
end
title('Bezier Surface');

%% Run to get Toolpath 


tool_enter = [BezSurfPts_u(1,1:2),stock_height];

if mod(i,2)==1
    tool_exit = [BezSurfPts_u(4,3*n-2:3*n-1),stock_height];
    exit = BezSurfPts_u(4,3*n-2:3*n);
else
    tool_exit = [BezSurfPts_u(1,3*n-2:3*n-1),stock_height];
    exit = BezSurfPts_u(1,3*n-2:3*n);
end

subplot(1,3,2)


for i=1:n
    %BezSurfPts_u(1:4,(3*i-2):3*i)=[u0(i,:);u1(i,:);u2(i,:);u3(i,:)];
    BezSurfPlot(BezSurfPts_u(1:4,(3*i-2):3*i),surfSmoothness,'r');
end

joint = [tool_enter;BezSurfPts_u(1,1:3)];
plot3(joint(:,1),joint(:,2),joint(:,3),'r');

for i = 1:n-1    
    if mod(i,2)==1
        joint = [ BezSurfPts_u(4,3*i-2:3*i) ; BezSurfPts_u(4,3*i+1:3*i+3) ];
    else 
        joint = [ BezSurfPts_u(1,3*i-2:3*i) ; BezSurfPts_u(1,3*i+1:3*i+3) ];
    end
        plot3(joint(:,1),joint(:,2),joint(:,3),'r');
end
title('Tool path');

joint = [exit;tool_exit];
plot3(joint(:,1),joint(:,2),joint(:,3),'r');
set(gcf, 'Position',  [0, 50, 2100, 600])

%% Run to Get adaptive tool path

SqX = (BezSurfPts_u(4,1)-BezSurfPts_u(4,4))^2;
SqY = (BezSurfPts_u(4,2)-BezSurfPts_u(4,5))^2;
SqZ = (BezSurfPts_u(4,3)-BezSurfPts_u(4,6))^2;

StepO_Dist = sqrt(SqX+SqY+SqZ);
StepO_Const = curveSmoothness/StepO_Dist;
curveSmoothness = stepOver*StepO_Const;

u0 = BezierCurve(points_u(1:4,    1:3  ),curveSmoothness);    % 4x3
u1 = BezierCurve(points_u(1:4,    4:6  ),curveSmoothness);
u2 = BezierCurve(points_u(1:4,    7:9  ),curveSmoothness);
u3 = BezierCurve(points_u(1:4,    10:12),curveSmoothness);

v0 = BezierCurve(points_v(1:4,    1:3  ),curveSmoothness);    % 4x3
v1 = BezierCurve(points_v(1:4,    4:6  ),curveSmoothness);
v2 = BezierCurve(points_v(1:4,    7:9  ),curveSmoothness);
v3 = BezierCurve(points_v(1:4,    10:12),curveSmoothness);

BezSurfPts_u=[];

n=length(u0);
subplot(1,3,3)

for i=1:n
    BezSurfPts_u(1:4,(3*i-2):3*i)=[u0(i,:);u1(i,:);u2(i,:);u3(i,:)];
    BezSurfPlot(BezSurfPts_u(1:4,(3*i-2):3*i),surfSmoothness,'#0072BD');
end

tool_enter = [BezSurfPts_u(1,1:2),stock_height];

if mod(i,2)==1
    tool_exit = [BezSurfPts_u(4,3*n-2:3*n-1),stock_height];
    exit = BezSurfPts_u(4,3*n-2:3*n);
else
    tool_exit = [BezSurfPts_u(1,3*n-2:3*n-1),stock_height];
    exit = BezSurfPts_u(1,3*n-2:3*n);
end

joint = [tool_enter;BezSurfPts_u(1,1:3)];
plot3(joint(:,1),joint(:,2),joint(:,3),'color','#0072BD');

for i = 1:n-1    
    if mod(i,2)==1
        joint = [ BezSurfPts_u(4,3*i-2:3*i) ; BezSurfPts_u(4,3*i+1:3*i+3) ];
    else 
        joint = [ BezSurfPts_u(1,3*i-2:3*i) ; BezSurfPts_u(1,3*i+1:3*i+3) ];
    end
        plot3(joint(:,1),joint(:,2),joint(:,3),'color','#0072BD');
end

joint = [exit;tool_exit];
plot3(joint(:,1),joint(:,2),joint(:,3),'color','#0072BD');

title('Adaptive Tool Path');

%% G-Code Generator

% fileName = sprintf('Code_190030017_%s.txt', datestr(now,'yyyy-mm-dd_HH-MM-SS'));
% fileID = fopen(fileName,'w');
fileID = fopen('Code_04-08-2022 09-00.txt','w');

fprintf(fileID,'%%\n(G-code output for Bezier Surface generated from given 4x4 matrix)');
fprintf(fileID,'\n(Generated by HARISHKUMAR LAXMIKANT GAJAKOSH)');
fprintf(fileID,'\n(As a part of COMPUTER INTEGRATED MANUFACTURING Project)');
fprintf(fileID,'\n(Guided By Prof RAKESH LINGAM');
fprintf(fileID,'\n(Creation date: %s)',datetime);
fprintf(fileID,'\n(Spindle Speed\t= 12000 RPM)\n(Tool\t= 1)');

fprintf(fileID,'\nN1 G90\nN2 G21');
fprintf(fileID,'\nN3 \tG00 \tX%.5f \tY%.5f \tZ%.5f \tF100',tool_enter(1),tool_enter(2),tool_enter(3));

counter = 4;
path = [3 tool_enter(1) tool_enter(2) tool_enter(3)];
for i=1:n
    %subplot(1,2,2)
    %title('Tool path');
    if mod(i,2)==1
        counter = GenCode(BezSurfPts_u(1:4,(3*i-2):3*i),fileID,surfSmoothness,counter);
    else
        counter = GenCode(BezSurfPts_u(4:-1:1,(3*i-2):3*i),fileID,surfSmoothness,counter);
    end
end
fprintf(fileID,'\nN%d \tG00 \tX%.5f \tY%.5f \tZ%.5f \tF100 \n%%',counter,tool_exit(1),tool_exit(2),tool_exit(3));
fclose(fileID);


%% Control Curves
%{
 plot3(u0(:,1),u0(:,2),u0(:,3),'r', u1(:,1),u1(:,2),u1(:,3),'r', u3(:,1),u3(:,2),u3(:,3),'r', u2(:,1),u2(:,2),u2(:,3),'r');
% plot3(v0(:,1),v0(:,2),v0(:,3),'r', v1(:,1),v1(:,2),v1(:,3),'r', v2(:,1),v2(:,2),v2(:,3),'r', v3(:,1),v3(:,2),v3(:,3),'r');


% plot3(r0(:,1),r0(:,2),r0(:,3),'b', r1(:,1),r1(:,2),r1(:,3),'r', r2(:,1),r2(:,2),r3(:,3),'g', r3(:,1),r3(:,2),r3(:,3),'--')
%}

