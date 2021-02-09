%% read image 256 x 256
im=double(imread('D:\Users\Lenovo\Desktop\pic\lena_256.bmp'));
subplot(3,3,1);
image(im);

im2=double(imread('D:\Users\Lenovo\Desktop\pic\car.jpg'));
subplot(3,3,4);
image(im2);
colormap(gray(256));

 %% lowpass mask
lp_mask = zeros(256,256);
lp_bound = round(256/10);

N = 0;
for i = 1:9
    lp_mask(i,1:9-N) = 1;
    N = N+1;
end

N = 0;
for i = 248:256
    lp_mask(i,1:1+N) = 1;
    N = N+1;
end

N = 0;
for i = 1:9
    lp_mask(i,248+N:256) = 1;
    N = N+1;
end

N = 0;
for i = 248:256
    lp_mask(i,256-N:256) = 1;
    N = N+1;
end
%% highpass mask
hp_mask = ones(256,256);
hp_mask = hp_mask - lp_mask;

%% image to 2d fourier transform (X Y refer to im)
Y = fft2(im);
%% inverse fourier transform
X = abs(ifft2(Y));
%% Y multiply lp_mask
Y_lowpass = Y .* lp_mask;
X_lowpass = abs(ifft2(Y_lowpass));
subplot(3,3,2);
image(X_lowpass);

% Y multiply hp_mask
Y_highpass = Y .* hp_mask;
X_highpass = abs(ifft2(Y_highpass));
subplot(3,3,3);
image(X_highpass);
colormap(gray(256));
%% P Q refer to im2
Q = fft2(im2);

%
Q_lowpass = Q .* lp_mask;
P_lowpass = abs(ifft2(Q_lowpass));
subplot(3,3,5);
image(P_lowpass);

%
Q_highpass = Q .* hp_mask;
P_highpass = abs(ifft2(Q_highpass));
subplot(3,3,6);
image(P_highpass);
colormap(gray(256));
%% lena's highpass + car's lowpass
mix = X_highpass + P_lowpass;
subplot(3,3,7);
image(mix);
colormap(gray(256));

%% lena's lowpass + car's highpass
mix1 = X_lowpass + P_highpass;
subplot(3,3,8);
image(mix1);
colormap(gray(256));
