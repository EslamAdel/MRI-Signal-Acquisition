 clc;
 clear all;
 close all;
 Gx = 10e-3; 
 FOVx = 20e-3;
 dx = 1e-4;
% dx = 10;
 protons = [1 0 0]';
 protons = repmat(protons,1,round(FOVx/dx));
 tau = 1e-3;%sec
 Accumulate = 1;
 dt = 1e-5; %sec
 T2 = 0.001; %sec
 [signalFFT, t] = getSignal(protons, Gx, FOVx, tau, Accumulate, T2,dt);
 figure,
 plot(t,real(signalFFT),'b','linewidth',1.5);
 grid on;
 title('The Magnitude of Signal S(t)');
 signal = fft(signalFFT);
 figure,
 plot(abs(circshift(signal', round(length(signal)/2))),'b','linewidth',1.5);
 grid on;
 title('Reconstructed Signal');