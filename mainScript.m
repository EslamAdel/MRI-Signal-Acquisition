clc;
clear all;
close all;
protons = [1 0 0]';
protons = repmat(protons,1,200);
Gx = 10; %mT/m
FOVx = 20; %mm
tau = 0.5;%sec
Accumulate = 1;
dt = 0.001; %sec
T2 = 1000;
[signalFFT, t] = getSignal(protons, Gx, FOVx, tau, Accumulate, T2,dt);
figure,
plot(t,real(signalFFT),'b','linewidth',1.5);
grid on;
title('The Magnitude of Signal S(t)');
signal = fft(signalFFT);
figure,
plot(abs(circshift(signal', round(length(signal)/2))),'b','linewidth',1.5);
grid on;