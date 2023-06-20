clear all; 
close all;
%% 
fileNr = '57.txt';
path = 'C:\Users\haral\Documents\specialisation-project\BuoyancyTerminalApp\InstalledApplication\BuoyancyApp\MissionLog\';
fileID = fopen((append(path, fileNr)));
%fileID = fopen('C:\Users\haral\Documents\specialisation-project\BuoyancyTerminalApp\InstalledApplication\BuoyancyApp\MissionLog\'+ fileNr' + '.txt');
%fileID = fopen(C:\Users\haral\Documents\skole\kyb_3_semester\prosjektoppgave\drive-download-20210218T105531Z-001\BuoyancyTerminalApp\InstalledApplication\BuoyancyApp\MissionLog\105.txt); % from Desember
C = textscan(fileID,'%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32', 'HeaderLines', 2);
fclose(fileID); 

CTD = load('..\Master-BV-simulation\CTD-probe\borsa14.04.2023.mat');

fileLength = length(C{1});
time            = C{1};

unfilteredDepth = C{11};
filteredDepth   = C{12};
batteryVoltage  = C{13};
TEMP117temperature = C{14};



fig1 = figure(1);
hold on
plot(TEMP117temperature(1:500), unfilteredDepth(1:500))
plot(CTD.Temperature, CTD.Depth)
hold off
set(gca,'YDir','reverse');
grid()
title("Temperature");
xlabel("Temperature [*C]");
ylabel("Depth [m]")
legend(["TMP117", "CTD-probe"]);

