protons = [1 0 0]';
protons = repmat(protons,1,200);
FOVx = 20; %mm
Gx = 10; %mT/m
tau = 1; %sec
signal = getSignal(protons, Gx, FOVx, tau);
t = 0:tau/length(signal):tau - tau/length(signal);
figure,
plot(t,signal);
signalFFT = fftshift(signal);
figure, plot(abs(signalFFT));
figure, plot(angle(signalFFT));
