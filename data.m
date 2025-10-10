clear;
recorded_data = readtable("raw_data.csv");

time_start = 580;
time_end = 17340;
recorded_time = recorded_data.time(time_start:time_end);
recorded_acceleration = recorded_data.linear_acceleration_y(time_start:time_end);

mass = .3255;
k = 0.01279291 % spring constant, N/m
sigma = -0.0079 % exponential decay rate, 1/s
omega_n_1 = sqrt(k / mass) % natural freq from measured mass/stiffness, rad/s
omega_n_2 = 1; % natural freq from accel, rad/s
zeta = sigma / omega_n_1 % damping ratio, dimensionless
c = zeta * 2 * sqrt(k * mass) % damping coeff, (N * s)/m
omega_d = omega_n_1 * sqrt(1 - zeta ^ 2) % damped freq, rad/s

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

% exponential fit
% b = -0.0079
[filtered_time, filtered_accel] = cleanData(recorded_time, recorded_acceleration);
[xData, yData] = prepareCurveData( filtered_time, filtered_accel );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [6.45416395706132 -0.00693825617525536];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


figure();
plot( fitresult, xData, yData );
title("Exponential Decay Curve Fit");
xlabel("time(s)")
ylabel("acceleration(m/s^2)")

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

