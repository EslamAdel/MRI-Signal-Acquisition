clc;
clear all;
close all;
  
Gx = 10e-3;   
objectWidth = 20e-3;  
Rx = 5e-4;  
protons = [1 0 0]';
protons = repmat(protons,1,round(objectWidth/Rx));
tau = 5e-3;
Accumulate = 1; 
dt = 0.1e-4;
  
T2 = 100;  
  
[signalFFT, t] = getSignal(protons, Gx, objectWidth, Rx, tau, Accumulate, T2,dt);
  
figure,
plot(t,real(signalFFT),'b','linewidth',1.5);
xlabel('Time (sec)');
ylabel('Mangnitude');
grid on;
title('The Magnitude of Signal S(t)');
 
 signal = fftshift(ifft(signalFFT));
 len = length(t);
 gamma = 2*pi*42.58*10^6;
 FOVx = 2*pi/(Gx*gamma*dt);
 x = [-FOVx/2+FOVx/len:FOVx/len:FOVx/2]*(10^3);
 figure;
 plot(x, abs(signal),'b','linewidth',1.5);
 xlabel('X (mm)');
 ylabel('Magnitude');
 axis([min(x)-2 max(x)+2 0 max(abs(signal))+0.2]);
 grid on;
 title('Reconstructed Signal');
