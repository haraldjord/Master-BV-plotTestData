clear all; 
close all;
%% 
fileNr = '74.txt';
path = 'missionLog\'; % Path to mission log 
fileID = fopen((append(path, fileNr)));
%fileID = fopen('C:\Users\haral\Documents\specialisation-project\BuoyancyTerminalApp\InstalledApplication\BuoyancyApp\MissionLog\'+ fileNr' + '.txt');
%fileID = fopen(C:\Users\haral\Documents\skole\kyb_3_semester\prosjektoppgave\drive-download-20210218T105531Z-001\BuoyancyTerminalApp\InstalledApplication\BuoyancyApp\MissionLog\105.txt); % from Desember
C = textscan(fileID,'%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32,%f32', 'HeaderLines', 2);
fclose(fileID); 
fileLength = length(C{1});
time            = C{1}; % ms
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

error = targetDepth - unfilteredDepth;
%%Moving-average filter
%    windowSize = 300;
%    b = (1/windowSize)*ones(1,windowSize);
%    a = 1;

%batt_filter = filter(b,a,batteryVoltage);


%%Plotting
close all;


%Vehicle measuredDepth + ref
fig1 = figure(1);
subplot(2,1,1);
    hold on;

    %SEGMENT 2
    hold on;
    plot((time(1:end)*0.001), unfilteredDepth(1:end));
    plot((time(1:end)*0.001), filteredDepth(1:end));
    plot((time(1:end)*0.001),targetDepth(1:end),':');
    plot((time(1:end)*0.001),zeros(fileLength),'--');
    xlim([0,360])
    %plot(simDepth1.Depth.Time,simDepth1.Depth.Data,'-.k');
    %plot(simDepth2.Depth.Time+600,simDepth2.Depth.Data,'-.k');
    legend('Measured Depth','Filtered Depth','Target Depth', 'Water surface');
    title('Measured Depth');
    xlabel('Time [s]');
    xlim([0 fileLength/2]);
    if max(unfilteredDepth) < max(targetDepth)
        ylim([min(unfilteredDepth), (max(targetDepth)+0.1)]);
    else
        ylim([min(unfilteredDepth), max(unfilteredDepth)]);
    end
    ylabel('Depth [m]');
    set(gca,'YDir','reverse');
    grid();

    %fig1.Position = [20 100 700 1000];
    hold off;

subplot(2,1,2);
    hold on;
    plot((time(1:fileLength)*0.001),pistonPosition(1:fileLength)*1000);
    plot((time(1:fileLength)*0.001), PIDoutput(1:fileLength)*1000, "--");
    xlabel('Time [s]');
    xlim([0 fileLength/2]);
    ylabel('Position [mm]');
    title('Piston position');
    legend("Piston position","PID output");
    grid();
    hold off;


%Pressure_Voltage, and measured depth
fig2 = figure(2);
subplot(3,1,1);
    hold on;
%Pressure Voltage
    yyaxis left
    plot((time(1:fileLength)*0.001), pressureVoltage(1:fileLength));
    ylabel('Voltage [V]');
    ylim([0.48, inf])
    
    yyaxis right
    plot((time(1:fileLength)*0.001), psi(1:fileLength),'--');
    ylabel('Pressure [psi]');
    
    legend('Pressure Input [V]','Pressure [psi]','Simulated','Location','southeast');
    title('Measured Pressure');
    xlabel('Time [s]');
    xlim([0 fileLength/2]);
    

% Measured Depth
subplot(3,1,2);
    %yyaxis left
    hold on;
    plot((time(1:fileLength)*0.001), filteredDepth(1:fileLength));
    plot((time(1:end)*0.001),targetDepth(1:end),':');
    plot((time(1:end)*0.001),zeros(fileLength),'--');
    ylabel('Depth [m]');
    set(gca,'YDir','reverse');
    hold off

    %yyaxis right
    %plot((time(1:fileLength)*0.001),pistonPosition(1:fileLength)*1000,'--');
    %ylabel('Piston Position [mm]');
    %set(gca,'YDir','reverse');

    legend('Measured Depth','Target Depth');
    xlabel('Time [s]');
    xlim([0 fileLength/2]);
    title('Measured Depth');


% Piston Position
    subplot(3,1,3);
    hold on;
    plot((time(1:fileLength)*0.001),pistonPosition(1:fileLength)*1000);
    plot((time(1:fileLength)*0.001),PIDoutput(1:fileLength)*1000,'--');
    legend('Piston Position','PID output');
    xlabel('Time [s]');
    xlim([0 fileLength]);
    ylabel('Position [mm]');
    title('Piston Position');
    hold off;

% Battery Voltage
    fig3 = figure(3);
    hold on;
    plot((time(1:fileLength)*0.001),batteryVoltage(1:fileLength),'b');
    %plot((time(windowSize:fileLength)*0.001),batt_filter(windowSize:fileLength),'r');
    %legend('Batt raw','Batt Filter');
    title('Battery Voltage');
    xlabel('Time [s]');
    xlim([0 fileLength]);
    ylabel('Voltage [V]');
    ylim([11.0 24.0])
    %%fig3.Position = [800 620 700 500];
    hold off;

    %%
fig4 = figure(4);
    hold on 
    plot((time(1:fileLength)*0.001), unfilteredDepth(1:fileLength) ,'r');
    plot((time(1:fileLength)*0.001), filteredDepth(1:fileLength),'b');
    title('EMA filtered Depth');
    xlabel('Time [s]'); %xlim([0,fileLength]);
    ylabel('Depth [m]'); %ylim([0, fileLength]);
    legend('raw mesurment', 'filtered measurement');
    set(gca,'YDir','reverse');
    grid();
    hold off;
    %%
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

fig6 = figure(6); % Temperature sensor
    plot(unfilteredDepth, TEMP117temperature);
    title('Temperature Sensor');
    xlabel('Time [s]')
    ylabel('Temperature [celsius]')
    grid();
   % ylim([15,20])
    
    
    
fig7 = figure(7);
    plot(time*0.001, Pterm*1000,time*0.001, Iterm*1000,time*0.001, Dterm*1000, time*0.001, PIDoutput*1000) 
    legend('P-term', 'I-term', 'D-term', 'PID-out');
    title('Contribution from PID terms')
    xlabel('Timer [s]')
    ylabel('Piston position [mm]')
    grid();
    
   
%Density
%     sampleData = load('testdata/CC1437011_20200605_085748');
%     densityInter = @(new_t) interp1(sampleData.Depth,sampleData.Density, new_t);
% 
%     fig8 = figure(8);
%     plot(sampleData.Density,sampleData.Depth);
%     title('Freshwater Tank Density');
%     xlabel('Density [kg/m3]');
%     ylabel('Depth [m]');
%     set(gca,'YDir','Reverse')
%     fig8.Position = [800 50 700 500];
%     
%     fig9 = figure(9);
%     plot(sampleData.Temperature,sampleData.Depth);
%     title('Freshwater Tank Temperature');
%     xlabel(['Temperature [' char(176) 'C]']);
%     ylabel('Depth [m]');
%     set(gca,'YDir','Reverse')
%     fig8.Position = [800 50 700 500];


% figure(99)
% hold on
% plot(KP_value);
% plot(KI_value);
% plot(KD_value);
% hold off
% legend("KP", "KI", "KD");

%% calculate velocity and acceleration.

% [vel, t_vel] = plot_velocity(filteredDepth, time,1);
% 
% figure(100);
% plot(t_vel, vel)
% title("Velocity");
% xlabel("Time [s]");
% ylabel("velocity [m/s]");
% grid()



%% plot simulated and measured mission
sim = load('simOut.mat'); % load simulated data

% if targetDepth(2) == sim.out.stepResponse.signals.values(2,1) % if sepoint sim == test
%     fig=figure(10)
%     subplot(2,1,1)
%         hold on 
%         plot(time*0.001, targetDepth)
%         plot(time*0.001, unfilteredDepth)
%         %plot(sim.out.stepResponse.time,
%         %sim.out.stepResponse.signals.values(:,1)) % simulated reference point 
%         plot(sim.out.stepResponse.time, sim.out.stepResponse.signals.values(:,2))
%         hold off
%         set(gca,'YDir','reverse');
%         legend('Target Depth','Measured Depth', 'Simulated Depth');
%         xlabel('Time [s]');
%         ylabel('Depth [m]');
%         title('Simulated vs measured step response')
%         grid()
%         xlim([0,418])
% 
% 
%     subplot(2,1,2);
%         hold on;
%         plot((time(1:fileLength)*0.001),pistonPosition(1:fileLength)*1000);
%         plot(sim.out.PistonPosition.time, sim.out.PistonPosition.signals.values*1000)
%         %plot((time(1:fileLength)*0.001), PIDoutput(1:fileLength), "--");
%         %plot(sim.out.PIDout.time, sim.out.PIDout.signals.values);
%         xlabel('Time [s]');
%         xlim([0 fileLength/2]);
%         ylabel('Position [mm]');
%         title('Piston position');
%         %legend("Piston position","PID output");
%         legend("piston position", "simulated piston position");
%         grid();
%         hold off;
%         xlim([0, 418])
% 
% 
% %      subplot(3,1,3)
% %         hold on;
% %         plot((time(1:fileLength)*0.001), PIDoutput(1:fileLength)*1000);
% %         plot(sim.out.PIDout.time, sim.out.PIDout.signals.values*1000);
% %         xlabel('Time [s]');
% %         xlim([0 fileLength/2]);
% %         ylabel('PID out [mm]');
% %         title('PID out');
% %         %legend("Piston position","PID output");
% %         legend("pid out", "simulated pid out");
% %         grid();
% %         hold off;
% %         xlim([0,360])
% 
% end
