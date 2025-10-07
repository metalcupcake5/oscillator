mass = 1;
k = 1; % spring constant, N/m
c = 0; % damping coeff, (N * s)/m
sigma = 1; % exponential decay rate, 1/s
omega_d = 1; % damped freq, rad/s
omega_n_1 = 1; % natural freq from measured mass/stiffness, rad/s
omega_n_2 = 1; % natural freq from accel, rad/s
zeta = 1; % damping ratio, dimensionless

% measured data (spring)
force = [];
displacement = [];

plot(displacement, force);

% measured data (phone)
accel = [];
time = [];
plot(time, accel);

figure();
hold on;
scatter(-sigma, omega_d)
scatter(-sigma, -omega_d)


