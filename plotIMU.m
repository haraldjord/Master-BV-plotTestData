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
fileLength = length(C{1});
time            = C{1};
missionNr       = C{2};
targetDepth     = C{3};
pistonPosition  = C{4};
PIDoutput       = C{5};
Pterm          = C{6};
Iterm          = C{7};
Dterm          = C{8};
pressureVoltage = C{9};
psi             = C{10};
unfilteredDepth = C{11};
filteredDepth   = C{12};
batteryVoltage  = C{13};
TEMP117temperature = C{14};

accel_x = C{15};
accel_y = C{16};
accel_z = C{17};
accel_sensitivity = C{18}; %accel_x/sensitivity = [g]
gyro_x = C{19};
gyro_y = C{20};
gyro_z = C{21};
gyro_sensitivity = C{22};

fig5 = figure(5); %motion sensor:
    %accelerometer.
    ax = accel_x./accel_sensitivity;
    ay = accel_y./accel_sensitivity;
    az = accel_z./accel_sensitivity;

subplot(3,1,1) %x-axis
    plot (time*0.001, ax)
    title('Accelerometer x-axis');    
    xlabel('time [s]')
    ylabel('g [m/s^2]')
    ylim([-1 1]);

subplot(3,1,2)
    plot(time*0.001, ay);
    title('Accelerometer y-axis');
    xlabel('time [s]')
    ylabel('g [m/s^2]')    
    ylim([-1 1]);

subplot(3,1,3)
    plot(time*0.001, az)
    title('Accelerometer z-axis');
    xlabel('time [s]')
    ylabel('g [m/s^2]')
    ylim([-1 1]);
    
    
    
    
%limit timeframe
s = 50
l = 120
time = time(s:end-l);% remove first s seconds and l last second.
ax = ax(s:end-l); 
ay = ay(s:end-l);
az = az(s:end-l);


offset_x = -5;
offset_y = 1.5;

tilt_x = atan(ax./az)*(180/pi) + offset_x; 
tilt_y = atan(ay./az)*(180/pi) + offset_y;


fig6 = figure(6);

subplot(2,1,1);
    plot(time*0.001, tilt_x);
    grid()
    title("Tilt x-axis");
    xlabel("time [s]")
    ylabel("angle [degrees]");

subplot(2,1,2);
    plot(time*0.001, tilt_y);
    grid()
    title("Tilt y-axis");
    xlabel("time [s]");
    ylabel("angle [degrees]");
    