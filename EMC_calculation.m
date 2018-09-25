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
R5 = 1e6;
%% Thermal noice for every resistor, calculated with the frequency difference
Uthgr = sqrt(4*k*T*df1*Rg);
Uth1 = sqrt(4*k*T*df1*R1);
Uth2 = sqrt(4*k*T*df1*R2);
Uth3 = sqrt(4*k*T*df1*R3);
Uth4 = sqrt(4*k*T*df1*R4);
Uth5 = sqrt(4*k*T*df1*R5);
%% current noise
Udc = 12;                       % Voltage source
S = 1e-6;                        
Ues = Udc*S*sqrt(log(100e3/10));

% thermal and current noise together
Ur1 = sqrt(Uth1^2+Ues^2);
Ur2 = sqrt(Uth2^2+Ues^2);

%% Noises without generator
% R1
V1_oG = Ur1*R2/(R2+R1);    % Voltage divider to get the voltage over Rp(Amplifier +)
% R2
V2_oG = Ur2*R1/(R1+R2);    % Voltage divider to get the voltage over Rp(Amplifier +)

%% Noice for every resistor without the other
% Rg
Rp = R1*R2/(R1+R2);     % paralell resistor of R1 and R2
Rges_g = Rp*Rg/(Rp+Rg); % paralell resistor of Rp and Rg
Vg = Uthgr*Rp/(Rp+Rg); % Voltage divider to get the voltage over Rp(Amplifier +)
% R1
Rp = Rg*R2/(Rg+R2);     % paralell resistor of Rg and R2
V1 = Ur1*Rp/(Rp+R1);    % Voltage divider to get the voltage over Rp(Amplifier +)
% R2
Rp = Rg*R1/(Rg+R1);     % paralell resistor of R1 and Rg
V2 = Ur2*Rp/(Rp+R2);    % Voltage divider to get the voltage over Rp(Amplifier +)
% R3 
% Outputterminal = output of the amplifier?
R34 = R3 + R4;          % seriell Resistors
Vout_3 = Uth3*R5/(R34+R5);
% R4 
% Outputterminal = output of the amplifier?
R34 = R3 + R4;          % seriell Resistors
Vout_4 = Uth4*R5/(R34+R5);
% R5
% Outputterminal = output of the amplifier?
R34 = R3 + R4;          % seriell Resistors
Vout_5 = -Uth5*R34/(R34+R5);

%% Noice after the Amplifier
Vout_g = (R4+R3)/(R4)*Vg;    % Outputvoltage of the Amplifier with respect to Rg
Vout_1 = (R4+R3)/(R4)*V1;    % Outputvoltage of the Amplifier with respect to R1
Vout_2 = (R4+R3)/(R4)*V2;    % Outputvoltage of the Amplifier with respect to R2

Vout_1_oG = (R4+R3)/(R4)*V1_oG; % Outputvoltage of the Amplifier with respect to R1 and wıthout generator
Vout_2_oG = (R4+R3)/(R4)*V2_oG; % Outputvoltage of the Amplifier with respect to R2 and wıthout generator
%% Combining the noises
V_noise = sqrt(Vout_g^2+Vout_1^2+Vout_2^2+Vout_3^2+Vout_4^2+Vout_5^2);
disp(['The total RMS noise voltage is ' ,num2str(V_noise*10^6),'µV.']);
