OnLandDistance = [0.25, 0.5, 1, 2, 4, 8, 16];
% FRESHWATER
freshChipAntOnLand = [-54, -67, -69, -72, -79, -91, -94];
freshDipoleAntOnLand = [-46, -53, -60, -67, -69, -79, -86];
% SALTWATER
saltChipAntOnLand = [-64, -67, -76, -77, -73, -86, -96];
saltDipoleAntOnLand = [-50, -52, -57, -72, -72, -75, -90];

SurfaceDistance = [0.25, 0.5, 1, 2];
% FRESHWATER
freshChipAntSurface = [-79,-82,-83,-93];
freshDipoleAntSurface = [-66,-70,-80,-85];
% SALTWATER
saltChipAntSurface = [-72,-78,-83,-87];
saltDipoleAntSurface = [-67,-69,-72,-81];

DepthSignal = [0, 2, 3, 5, 8, 9, 10, 11, 12, 13, 14];
% FRESHWATER
freshChipAntUnderWater = [-54, -79, -81, -84, -92, -93, -95, -96, -97, -98, NaN];
freshDipoleAntUnderWater = [-46, -65, -68, -74, -84, -85, -90, -92, -94, -96, -98];
% SALTWATER
saltChipAntUnderWater = [-63, -83, -98, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN];
saltDipoleAntUnderWater = [-55, -67, -74, -92, NaN, NaN, NaN, NaN, NaN, NaN, NaN];


DepthDataRate = [0, 2, 3, 5, 8, 9, 10];
% FRESHWATER
freshChipDataRateUnderWater = [4096, 4096, 4096, 2743,1233,2704,NaN];
freshDipoleDataRateUnderWater = [4125, 4147, 4140, 4120, 4027, 4095, 2321];
% SALTWATER
saltChipDataRateUnderWater = [4090, 3338, 2543, NaN, NaN, NaN, NaN];
saltDipoleDataRateUnderWater = [4114, 3977, 3900, 2637, NaN, NaN, NaN];



close all;
    
 fig1 = figure(1);
    fig1.Position = [700 400 500 500];
    hold on;
    plot(OnLandDistance,freshChipAntOnLand),
    plot(OnLandDistance,freshDipoleAntOnLand),
    plot(OnLandDistance,saltChipAntOnLand,'--b'),
    plot(OnLandDistance,saltDipoleAntOnLand,'--r'),
    title('Signal Strength On Land'),
    legend('Freshwater, chip antenna','Freshwater, dipole antenna','Saltwater, chip antenna','Saltwater, dipole antenna')
    xlabel('Distance [m]'), ylabel('RSSI [dBm]')
    
 fig2 = figure(2);
    fig2.Position = [700 10 500 500];
    hold on;
    plot(SurfaceDistance,freshChipAntSurface),
    plot(SurfaceDistance,freshDipoleAntSurface),
    plot(SurfaceDistance,saltChipAntSurface,'--b'),
    plot(SurfaceDistance,saltDipoleAntSurface,'--r'),
    title('Signal Strength At Surface'),
    legend('Freshwater, chip antenna','Freshwater, dipole antenna','Saltwater, chip antenna','Saltwater, dipole antenna')
    xlabel('Distance [m]'), ylabel('RSSI [dBm]')

 fig3 = figure(3);
    fig3.Position = [0 400 500 500];
    hold on;
    plot(DepthSignal,freshChipAntUnderWater),
    plot(DepthSignal,freshDipoleAntUnderWater),
    plot(DepthSignal,saltChipAntUnderWater,'--b'),
    plot(DepthSignal,saltDipoleAntUnderWater,'--r'),
    title('Signal strength Under Water')
    legend('Freshwater, chip antenna','Freshwater, dipole antenna','Saltwater, chip antenna','Saltwater, dipole antenna')
    xlabel('Depth [cm]'), ylabel('RSSI [dBm]')
    
 fig4 = figure(4);
    fig4.Position = [0 10 500 500];
    hold on;
    plot(DepthDataRate,freshChipDataRateUnderWater),
    plot(DepthDataRate,freshDipoleDataRateUnderWater),
    plot(DepthDataRate,saltChipDataRateUnderWater,'--b'),
    plot(DepthDataRate,saltDipoleDataRateUnderWater,'--r'),
    title('Data Rate Under Water')
    ylim([0,5000])
    legend('Freshwater, chip antenna','Freshwater, dipole antenna','Saltwater, chip antenna','Saltwater, dipole antenna')
    xlabel('Depth [cm]'), ylabel('Data Rade [B/Sec]')
    
    