%% AE 142 Project 1; Svitlana Kuklenko
%% Direct Interplanetary Hohmann Transfer Trajectory of Europa Clipper from Earth to Jupiter

% Define the launch date, time, and velocity
launch_date = datetime('2024-10-11');
launch_time = datetime('11:00:00');
launch_velocity = 24.13; % km/s

% Define the gravitational parameters of Earth and Jupiter
mu_earth = 3.986e5; % km^3/s^2
mu_jupiter = 1.2669e8; % km^3/s^2

% Define the positions and velocities of Earth and Jupiter
r_earth = [147.09e6; 0; 0]; % km
v_earth = [0; 29.784; 0]; % km/s
r_jupiter = [-740.52e6; -629.20e6; 0]; % km
v_jupiter = [13.072; -15.173; 0]; % km/s

% Calculate the spacecraft's trajectory from Earth to Jupiter using a patched conic approximation
[~, ~, ~, ~, v_inf, ~, ~, ~, ~, ~, ~, ~] = lambertMR(r_earth, r_jupiter, (2*pi - (245.0/180*pi))/86400, mu_earth, mu_jupiter, 0, 0, 0);

% Calculate the periapsis of the spacecraft's trajectory around Jupiter
r_p = mu_jupiter / v_inf^2;

% Calculate the delta-v required for the gravity assist
delta_v_gravity_assist = sqrt(mu_jupiter/r_p) - v_inf;

% Define the gravitational parameter of Europa
mu_europa = 3.203e5; % km^3/s^2

% Define the positions and velocities of Jupiter and Europa
r_jupiter = [0; 0; 0]; % km
v_jupiter = [0; 0; 0]; % km/s
r_europa = [671100; 0; 0]; % km
v_europa = [0; 13.740; 0]; % km/s

% Calculate the delta-v required for the Hohmann transfer
r_transfer = norm(r_europa - r_jupiter);
delta_v_hohmann = sqrt(mu_jupiter/r_jupiter)*(sqrt(2*r_europa/(r_transfer + r_europa)) - 1) + sqrt(mu_europa/r_europa)*(1 - sqrt(2*r_jupiter/(r_transfer + r_jupiter)));

% Calculate the transfer orbit
a_transfer = (r_europa + r_jupiter)/2;
e_transfer = (r_europa - r_jupiter)/(r_europa + r_jupiter);
i_transfer = acos(dot([0; 0; 1], (r_europa - r_jupiter)/(norm(r_europa - r_jupiter))));
RAAN_transfer = 0;
w_transfer = acos(dot(e_transfer, [1; 0; 0])/norm(e_transfer));
TA_transfer = pi;
