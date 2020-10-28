%%
im1 = double(imread('D:\Users\Lenovo\Desktop\pic\36.gif'));
im2 = double(imread('D:\Users\Lenovo\Desktop\pic\39.gif'));
subplot(1,2,1);
image(im1);
subplot(1,2,2);
image(im2);
colormap(gray(256));

%% NRMSE
temp = (im2 - im1).^2;
upper = sum(sum(temp));
bottom = sum((sum((im1).^2)));

NRMSE = (upper/bottom)^(1/2);

%% PSNR for RGB
im3 = double(imread('D:\Users\Lenovo\Desktop\pic\Baboon1.bmp'));
im4 = double(imread('D:\Users\Lenovo\Desktop\pic\Barbara_color.jpg'));
figure();
subplot(1,2,1);
image(im3/255);
subplot(1,2,2);
image(im4/255);

Xmax = 255;

im3R = im3(:,:,1);
im3G = im3(:,:,2);
im3B = im3(:,:,3);

im4R = im4(:,:,1);
im4G = im4(:,:,2);
im4B = im4(:,:,3);

tempR = (im4R - im3R)^2;
tempG = (im4G - im3G)^2;
tempB = (im4B - im3B)^2;

sumR = sum(sum(tempR));
sumG = sum(sum(tempG));
sumB = sum(sum(tempB));

temp_out = sumR + sumG + sumB;

[m, n, d] = size(im3); % d = m x n x dimension(R,G,B)
PSNR = 10*log10((3*m*n*((Xmax)^2)/temp_out));
