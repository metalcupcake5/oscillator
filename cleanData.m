function [filtered_time, filtered_accel] = cleanData(time, acceleration)
    [peaks, locations] = findpeaks(acceleration, time, "MinPeakDistance", 0.4);
    
    %figure();
    %scatter(locations, peaks)
    
    filtered_time = [];
    filtered_accel = [];
    for i = 1:length(peaks)
        if peaks(i) > 1 % filter peaks under 1
            filtered_time(length(filtered_time) + 1) = locations(i);
            filtered_accel(length(filtered_accel) + 1) = peaks(i);
        end
    end
    
    %figure();
    %scatter(filtered_time, filtered_accel);
    
end