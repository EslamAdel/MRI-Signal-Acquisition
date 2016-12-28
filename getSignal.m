function [signal, time] = getSignal(protons, Gx, objectWidth, Rx, tau, phaseAcc, T2, dt)
%% [signal, time] = getSignal(protons, Gx, objectWidth, tau, phaseAcc, T2, dt)
% Simulate MRI signal aquisition of one dimentional object.
% inputs : 
% protons : A matrix of protons after excitation they all must be in phase
%           each proton is a 3D vector with no component in Z direction its 
%           size is Number of protons x 3
%
% Gx : The Gradient field in x direction in T/m.
%
% objectWidth : The Width of object in x direction in m.
%
% Rx : resolution of object in x dimention in m.
%
% tau : The recieving time in seconds. 
%
% pahseAcc : Apply phase accumulation before recieving or not 
%            Its value must be 0 or 1
%
% T2 : The relaxation constant T2 in seconds, To ignore T2 effect provide a
%      large value of it.
%
% dt : The samlping time in seconds.
%
% Output : 
% signal : recieved Signal in time (it is a complex signal)
%
% time : the time interval according to tau and dt.
%
% Example : 
% clc;
% clear all;
% close all;
% 
% %% Setting parameters
% Gx = 10e-3;  % in T/m
% objectWidth = 20e-3;  % in m
% Rx = 5e-4; % in m
% protons = [1 0 0]';
% protons = repmat(protons,1,round(objectWidth/Rx));
% tau = 5e-3;  %sec
% Accumulate = 1; 
% dt = 0.1e-4; %sec
% 
% %% Ignore T2 Effect 
% T2 = 100;  %sec
% 
% %% Start Simulation
% [signalFFT, t] = getSignal(protons, Gx, objectWidth, Rx, tau, Accumulate, T2,dt);
% 
% %% Plot the sampled k-space 
% figure,
% plot(t,real(signalFFT),'b','linewidth',1.5);
% xlabel('Time (sec)');
% ylabel('Mangnitude');
% grid on;
% title('The Magnitude of Signal S(t)');
% 
% %% Plot Reconstructed Signal from sampled k-space
% signal = fftshift(ifft(signalFFT));
% len = length(t);
% gamma = 2*pi*42.58*10^6; %Hz/T
% FOVx = 2*pi/(Gx*gamma*dt);
% x = [-FOVx/2+FOVx/len:FOVx/len:FOVx/2]*(10^3);
% figure;
% plot(x, abs(signal),'b','linewidth',1.5);
% xlabel('X (mm)');
% ylabel('Magnitude');
% axis([min(x)-2 max(x)+2 0 max(abs(signal))+0.2]);
% grid on;
% title('Reconstructed Signal');
%
% Author : 
% Eslam Mahmoud <eslam.adel.mahmoud.ali@gmail.com>

% initialize The rotated protons matrix.
rotatedProtons = protons;

%%  X intervals according to objectWidth.
x = -1*objectWidth/2:Rx:objectWidth/2-Rx;

%% Get angular frequency for each proton accodring to Gx and X 
gamma = 2*pi*42.58*10^6; %Hz/T

% w = gamma * B
w = gamma*Gx.*x; %in rad/sec 

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

%Initialize waitbar and setting wait message.
h = waitbar(0, 'please Wait ...');

for t = time(1:end)
    
    % Update wait bar 
    waitbar(t/tau);
    
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

% Close the wait bar
close(h); 
end

