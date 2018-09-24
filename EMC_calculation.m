% Test 1
clc;
clear;

k = 1.38e-23;       % Boltzman
T = 273+75;         % Temperature in Kelvin
df1 = 100e3-10;     % difference of Frequency
df2 = 100e3;        % Frequency without difference because 10Hz<<100kHz
% Resistors
Rg = 1e3;           
R1 = 200e3;         
R2 = 200e3;
R3 = 19e3;
R4 = 1e3;

%% Thermal noice for every resistor, calculated with the frequency difference
Uthgr = sqrt(4*k*T*df1*Rg);
Uth1 = sqrt(4*k*T*df1*R1);
Uth2 = sqrt(4*k*T*df1*R2);
Uth3 = sqrt(4*k*T*df1*R3);
Uth4 = sqrt(4*k*T*df1*R4);

%% current noise
Udc = 12;                       % Voltage source
S = 1e-6;                        
Ues = Udc*S*sqrt(log(100e3/10));

% thermal and current noise together
Ur1 = sqrt(Uth1^2+Ues^2);
Ur2 = sqrt(Uth2^2+Ues^2);

%% 
Rp= R1*R2/(R1+R2);      % paralell resistor of R1 and R2
Rges = Rp*Rg/(Rp+Rg);   % paralell resistor of Rp and Rg
Vth = Uthgr*Rp/(Rp+Rg); % Voltage divider to get the voltage over Rp(Amplifier +)
%% 
Vout = (R4+R3)/(R4)*Vth; % Outputvoltage of the Amplifier