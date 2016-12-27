 clc;
 clear all;
 close all;
 
 %% Setting parameters
 Gx = 10e-3;  % in T/m
 FOVx = 20e-3;  % in m
 Rx = 5e-4; % in m
 protons = [1 0 0]';
 protons = repmat(protons,1,round(FOVx/Rx));
 tau = 5e-3;  %sec
 Accumulate = 1; 
 dt = 0.1e-4; %sec
 fs = 1/dt;
 
 %% Ignore T2 Effect 
 T2 = 100;  %sec
 
 %% Start Simulation
 [signalFFT, t] = getSignal(protons, Gx, FOVx, Rx, tau, Accumulate, T2,dt);
 
 %% Plot the sampled k-space 
 figure,
 plot(t,real(signalFFT),'b','linewidth',1.5);
 xlabel('Time (sec)');
 ylabel('Mangnitude');
 grid on;
 title('The Magnitude of Signal S(t)');
 
 %% Plot Reconstructed Signal from sampled k-space
 signal = fftshift(ifft(signalFFT));
 w = [-length(t)/2+1:length(t)/2]*2*pi*fs/length(t);
 figure,
 plot(w, abs(signal),'b','linewidth',1.5);
 xlabel('Frequency w (rad/sec)');
 ylabel('Magnitude');
 axis([-fs/2 fs/2]);
 grid on;
 title('Reconstructed Signal');