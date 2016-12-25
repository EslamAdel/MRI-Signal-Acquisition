function [signal, time] = getSignal(protons, Gx, FOVx, tau, phaseAcc, T2, dt)
%% [signal, time] = getSignal(protons, Gx, FOVx, tau, phaseAcc, T2, dt)
% Simulate MRI signal aquisition of one dimentional object.
% inputs : 
% protons : A matrix of protons after excitation they all must be in phase
%           each proton is a 3D vector with no component in Z direction its 
%           size is Number of protons x 3
%
% Gx : The Gradient field in x direction its value must be in mT/m
%
% FoVx : The Field of view in x direction it is the lenght of the 1D object
%        it must be in mm.
%
% tau : The recieving time in seconds 
%
% pahseAcc : Apply phase accumulation before recieving or not 
%            Its value must be 0 or 1
%
% T2 : The relaxation constant T2 in seconds, To ignore T2 effect provide a
%      large value of it.
%
% dt : The samlping time in seconds it dt = 0 then it will be calculated
%      using equation 5.77 using Gx and FOVx and gyromagnetic ratio.
% Output : 
% signal : recieved Signal in time (it is a complex signal) 
% time : the time interval according to tau and dt.
%
% Example : 
% clc;
% clear all;
% close all;
% protons = [1 0 0]';
% protons = repmat(protons,1,200);
% Gx = 10; %mT/m
% FOVx = 20; %mm
% tau = 0.5;%sec
% Accumulate = 1;
% dt = 0.001; %sec
% T2 = 1000; %sec
% [signalFFT, t] = getSignal(protons, Gx, FOVx, tau, Accumulate, T2,dt);
% figure,
% plot(t,real(signalFFT),'b','linewidth',1.5);
% grid on;
% title('The Magnitude of Signal S(t)');
% signal = fft(signalFFT);
% figure,
% plot(abs(circshift(signal', round(length(signal)/2))),'b','linewidth',1.5);
% grid on;
% title('Reconstructed Signal');
%
% Author : 
% Eslam Mahmoud <eslam.adel.mahmoud.ali@gmail.com>

%% Get Rx (resolution in X direction).
Rx = FOVx / size(protons, 2); % in mm

% initialize The rotated protons matrix.
rotatedProtons = protons;

%%  X intervals according to FOVx.
x = -1*FOVx/2:Rx:FOVx/2-Rx; %in mm

%% Get angular frequency for each proton accodring to Gx and X 
gamma = 2*pi*42.6; %MHz/T

% w = gamma * x
w = gamma*Gx.*x; %in rad/sec 

%% Get dt equation 5.77 if not provided
if dt == 0
    dt = 2*pi/(Gx*gamma*FOVx); % in seconds
end

%% Make A phase accumulation if is set 
if phaseAcc == 1
    % Apply negative gradient -Gx for tau/2 period
    angles = -1*w*tau/2;
    for i = 1:size(protons, 2)
        protons(:,i) = rotateVector(protons(:,i), angles(i), 'Z');
    end
    % T2 relaxation
    protons = protons.*exp(-tau/(2*T2));
end

%% Start Aquisition
% Time interval
time = 0:dt:tau-dt;

% Initialize signal matrix
signal = zeros(1,length(time));

% A dummy variable for indexing
idx = 1;
for t = time(1:end)
    
    % Get rotation angles for all protons in that moment of time
    angles = w*t;
    
    % loop to rotate each proton with its corresponding angle
    for i = 1:size(protons, 2)
        rotatedProtons(:,i) = rotateVector(protons(:,i), angles(i), 'Z');
    end
    
    % Now Sum all protons.
    totalM = sum(rotatedProtons, 2).*exp(-t/T2);
    
    % Get the signal Mxy = Mx + iMy
    signal(idx) = totalM(1) + totalM(2)*1j;
    
    % increment the index.
    idx = idx + 1;
end   
end

