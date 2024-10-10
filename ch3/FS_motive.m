clear;

t=[-4:0.001:4]';
x1=2/pi*cos(pi*t-pi/2);
x2=x1 + 2/(2*pi)*cos(2*pi*t+pi/2);
x3=x2 + 2/(3*pi)*cos(3*pi*t-pi/2);
x4=x3 + 2/(4*pi)*cos(4*pi*t+pi/2);
figure; 
subplot(2,2,1); plot(t,x1); title('N=1'); grid;
subplot(2,2,2); plot(t,x2); title('N=2'); grid;
subplot(2,2,3); plot(t,x3); title('N=3'); grid;
subplot(2,2,4); plot(t,x4); title('N=4'); grid;

N=100;
x=zeros(length(t),1);
for k = 1:N
    if (mod(k,2)==0)
        x = x + 2/(k*pi)*cos(k*pi*t+pi/2);
    else
        x = x + 2/(k*pi)*cos(k*pi*t-pi/2);
    end
end

figure; plot(t,x); grid