%% ToolPath Simulator

% Takes gcode as input and gives Tool path as the output
% But must ensure to put '(' before the N1 and G 

clear;clc;clear;
simID = fopen('Code_04-08-2022 09-00.txt');
textscan(simID, 'THIS DOES NOT OCCUR', 1, 'CommentStyle', '%');
data = textscan(simID,'N%d G%d X%f Y%f Z%f','CommentStyle','(');
graph = [ data{1,3} data{1,4} data{1,5}];
% simID = fopen('Freeform_surface_1.nc');
% data = textscan(simID,'N%d X%f Y%f Z%f','CommentStyle','(');
% graph = [ data{1,2} data{1,3} data{1,4} ];

%{
 x = data{1,2};
% y = data{1,3};
% z = data{1,4};
% plot3(x,y,z)
%}

plot3(graph(:,1),graph(:,2),graph(:,3),'o-')
hold on
%plot3(64.4600000000000,0.00500000000000000,-11.8360000000000,'o')
fclose(simID);
grid on