recorded_data = readtable("raw_data.csv");

time_start = 580;
time_end = 17340;
recorded_time = recorded_data.time(time_start:time_end);
recorded_acceleration = recorded_data.linear_acceleration_y(time_start:time_end);

mass = 1;
k = 1; % spring constant, N/m
c = 0; % damping coeff, (N * s)/m
sigma = 1; % exponential decay rate, 1/s
omega_d = 1; % damped freq, rad/s
omega_n_1 = 1; % natural freq from measured mass/stiffness, rad/s
omega_n_2 = 1; % natural freq from accel, rad/s
zeta = 1; % damping ratio, dimensionless

% measured data (spring)
force = [0 3.2 12.3 21.6 30.6 38.9 48.4].*0.001; %convert g to kg
displacement = [0 50 100 150 200 250 300].*0.01; %convert cm to m

%curve fitting (with Curve Fitting Toolbox).
[xData, yData] = prepareCurveData( displacement, force );
ft = fittype( 'poly2' );
[fitresult, gof] = fit( xData, yData, ft );

figure();
plot( fitresult, xData, yData );
title("Experimental Data (Spring Characterization)")
xlabel("Displacement (m)");
ylabel("Force (N)");

% measured data (phone)
time = recorded_time;
accel = recorded_acceleration;
figure();
plot(time, accel);
title("Experimental data (Phone)")
xlabel("Time (s)");
ylabel("Acceleration (m/s^2)")

% complex exponential coeffs
figure();
scatter(-sigma, omega_d);
hold on;
scatter(-sigma, -omega_d);
title("Complex Exponential Coefficients")
xlabel("-\sigma")
ylabel("\omega_d")

