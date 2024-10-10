
% Example of Fourier transform - filtering of a sound signal

clear all;
close all;

[X fs]=audioread('domisol.wav');    % original audio
% fs: sampling frequency, 22KHz
N=length(X); % number of samples 


% Fourier transform with cut-off 
Y=fft(X); 
freq=fs*[0:N-1]/N;  % frequency axis (Hz), fs=22 KHz 
Cutoff_freq = 1000; % Hz
Y1=zeros(N,1);  
Y1(1:Cutoff_freq*2)=Y(1:Cutoff_freq*2);  
% remove high freq. component in freq. domain (apply low-pass filter)
% cut off frequency = 1000 Hz 

X1=ifft(Y1);
audiowrite('filtered_domisol.wav', real(X1),fs); % modified wave file!!


p1=audioplayer(X,fs);
p2=audioplayer(X1,fs);

play(p1);
pause;
play(p2);


% time-domain representation of signal
t=(1:N)/fs;
figure; 
subplot(2,1,1);plot(t,X); axis([0 2 -0.2 0.2]); title('original signal');
subplot(2,1,2);plot(t,real(X1)); axis([0 2 -0.2 0.2]); title('filtered signal');
xlabel('time (sec)'); ylabel('magnitude');


figure;
subplot(2,1,1); plot(freq/1000,abs(Y));  axis([0 4 0 max(abs(Y))]);
title('frequency domain: original');
subplot(2,1,2); plot(freq/1000,abs(Y1));  axis([0 4 0 max(abs(Y1))]);
title(' frequency domain: filtered');
xlabel('frequency (KHz)'); ylabel('magnitude');


