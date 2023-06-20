function [v,t_v] = plot_velocity(depth,time_ms, useFilter)
%CLAC_VELOCITY Summary of this function goes here
%   Detailed explanation goes here
%   Calculate velocity based on raw depth measurments (unfiltered)


%Verify that depth and time has same length
if (length(depth) ~= length(time_ms))
    fprintf("Warning: time and depth has different sizes!");
    v = NaN(1);
    t_v = NaN(1);
    return;
end

if useFilter 
    windowSize = 5; 
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;  
   depth_filter =  filter(b,a,depth);
   x = depth_filter;
else
    x = depth;
end

time_s = time_ms*0.001; % time in seconds 

% delta_depth/delta_time 
dx = NaN(length(depth)-1,1);
dt = NaN(length(time_ms)-1,1);
for i = 1:(length(depth)-1) 
    dx(i) = x(i+1) - x(i);
    dt(i) = time_s(i+1) - time_s(i);
end


v = dx./dt;
vFilter = filter(b,a,v);
t_v = time_s(1:(end-1));

dv = NaN(length(v)-1,1);
for i=1:(length(v)-1)
    dv(i) = vFilter(i+1) - vFilter(i);
end

%ddt = dt.^2;
acc = dv./(dt(end-1));
accFilter = filter(b,a,acc);
t_a = time_s(1:(end-2));


figure(100);
subplot(3,1,1)
    hold on
    plot(time_s, depth)
%     if filter
        plot(time_s, depth_filter)
        legend("depth", "filtered depth");
%     end
    hold off 
    xlabel("time [s]");
    ylabel("depth [m]");
    title("depth")
    set(gca,'YDir','Reverse')
    grid();
    

subplot(3,1,2)
    hold on
    plot(t_v, v)
    plot(t_v,vFilter)
    hold off
    title("Velocity");
    xlabel("Time [s]");
    ylabel("velocity [m/s]");
    grid()
    
subplot(3,1,3)
    hold on
    plot(t_a, acc)
    plot(t_a, accFilter);
    hold on
    title("Acceleration");
    ylabel("m/s^2");
    grid()
    
end

