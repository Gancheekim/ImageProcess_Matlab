%%
im=double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (10).gif'));
subplot(2,3,1);
image(im);
colormap(gray(256));

%% erosion
[m,n] = size(im);

for i = 2:m-1
    for j = 2:n-1
        im1(i,j) = im(i,j) & im(i-1,j) & im(i+1,j) & im(i,j-1) & im(i,j+1);
    end
end

subplot(2,3,2);
image(im1*255);
colormap(gray(256));

%% erosion 3 times

[m,n] = size(im1);
for i = 2:m-1
    for j = 2:n-1
        im2(i,j) = im1(i,j) & im1(i-1,j) & im1(i+1,j) & im1(i,j-1) & im1(i,j+1);
    end
end

[m,n] = size(im2);
for i = 2:m-1
    for j = 2:n-1
        im3(i,j) = im2(i,j) & im2(i-1,j) & im2(i+1,j) & im2(i,j-1) & im2(i,j+1);
    end
end

subplot(2,3,3);
image(im3*255);
colormap(gray(256));
title('erosion 3 time');
%% dilation
bin = double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (38).gif'));
subplot(2,3,4);
image(bin*255);
colormap(gray(256));

[m,n] = size(bin);

for i = 2:m-1
    for j = 2:n-1
        bin1(i,j) = bin(i,j) | bin(i-1,j) | bin(i+1,j) | bin(i,j-1) | bin(i,j+1);
    end
end

subplot(2,3,5);
image(bin1*255);
colormap(gray(256));

% dilation 3 times
[m,n] = size(bin1);
for i = 2:m-1
    for j = 2:n-1
        bin2(i,j) = bin1(i,j) | bin1(i-1,j) | bin1(i+1,j) | bin1(i,j-1) | bin1(i,j+1);
    end
end

[m,n] = size(bin2);
for i = 2:m-1
    for j = 2:n-1
        bin3(i,j) = bin2(i,j) | bin2(i-1,j) | bin2(i+1,j) | bin2(i,j-1) | bin2(i,j+1);
    end
end

subplot(2,3,6);
image(bin3*255);
colormap(gray(256));
title('dilation 3 time');