function signal = getSignal(protons, Gx, FOVx, tau)
%getSignal Summary of this function goes here
% Gx in mT/m
% FOVx in mm.
% tau in sec.
%   Detailed explanation goes here
%% Get Rx (resolution in X direction) in meters
Rx = FOVx / size(protons, 2); % in mm
rotatedProtons = protons;

%% Position Matrix in X
x = -1*FOVx/2:Rx:FOVx/2; %in mm 

%% Rotation matrix due to Gx 
gamma = 42.6; %MHz/T

% w = gamma * x
w = gamma*Gx.*x;

%% Get dt equation 5.77
dt = 2*pi/(Gx*gamma*FOVx);

time = 0:dt:tau;
signal = zeros(1,length(time));
for t = 0:dt:tau
    angles = w*t;
    for i = 1:size(protons, 2)
        rotatedProtons(:,i) = rotateVector(protons(:,i), angles(i));
    end
    totalM = sum(rotatedProtons, 2);
    signal(t) = norm(totalM);
end

