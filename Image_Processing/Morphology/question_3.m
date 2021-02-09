%%
x=double(imread('D:\Users\Lenovo\Desktop\pic\bmp\cameraman.bmp'));
subplot(1,3,1);
image(x);
colormap(gray(256));

%% blurred image ( y is output )
[m,n] = size(x);

e_array = zeros(11,11);
a = 1;
b = 1;

for i = -5:5
    for j = -5:5
        e_array(a,b) = exp(-0.3*(i^2 + j^2));
        b = b+1;
    end
    b = 1;
    a = a+1;
end

s = 1/sum(sum(e_array));

k = s .* e_array;

an = 0.9;
noise = an*(rand(256,256)-0.5);

y = conv2(x,k,'same') + noise;
subplot(1,3,2);
image(y);
colormap(gray(256));

%% equalizer

k_1 = k(1:6,6:11);
k_2 = k(7:11,6:11);
k_3 = k(1:6.1:5);
k_4 = k(7:11,1:5);

k1 = zeros(256,256);
k1(1:5,1:6) = k_2;
k1(251:256,1:6) = k_1;
k1(1:5,252:256) = k_4;
k1(251:256,252:256) = k_3;

K = fft2(k1);

C = 0.01;
H = 1./((C./conj(K))+K);

Y = fft2(y);

ans = H .* Y;

ans1 = ifft2(ans);
subplot(1,3,3);
image(ans1);
colormap(gray(256));

