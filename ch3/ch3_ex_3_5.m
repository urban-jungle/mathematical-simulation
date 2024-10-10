% example 3.5
clear;

T1=1;
T=4;
N_FT=10000;

t = -2*T:0.0001:2*T;

w0 = 2*pi/T;
a0 = 2*T1/T;
a = zeros(N_FT,1); % FS coefficient

for k = 1:N_FT
    a(k)=sin(k*w0*T1)/(k*pi);
    %a(k)=(-1)^k*j/(k*pi);
end

x = zeros(length(t),1);

for k = 1:N_FT
    x = x+2*real(a(k)*exp(j*k*w0*t'));
    %x = x+ 2*abs(a(k))*cos(k*w0*t'+angle(a(k)));
end

x=x+a0;

figure;
%subplot(2,1,1);
plot(t,x);
xlabel('time (sec)'); ylabel('x(t)'); 
title('CT Fourier series representation');
grid

%subplot(2,1,2);stem([0:N_FT]',[a0; a]);
%xlabel('k'); ylabel('magnitude of a(k)');




