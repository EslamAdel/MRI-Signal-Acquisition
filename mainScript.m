clc;
clear;
close all;
protons = [1 0 0]';
protons = repmat(protons,1,200);
FOVx = 20; %mm
Gx = 10; %mT/m
tau = 0.5;%sec
dt = 0.001; %sec
rotatedProtons = getSignal(protons, -1*Gx, FOVx, tau,1, 1000,0);
[signalFFT, t] = getSignal(rotatedProtons, Gx, FOVx, tau, 0, 1000,dt);
figure,
plot(t,real(signalFFT),'b','linewidth',1.5);
grid on;
title('The Magnitude of Signal S(t)');
signal = fft(signalFFT);
figure,
plot(abs(circshift(signal', round(length(signal)/2))),'b','linewidth',1.5);
grid on;
title('Reconstructed Signal');