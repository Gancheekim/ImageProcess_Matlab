%% opening 3 times
im=double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (21).gif'));
subplot(1,3,1);
image(im*255);
colormap(gray(256));

%% erosion
[m,n] = size(im);

for i = 2:m-1
    for j = 2:n-1
        im1(i,j) = im(i,j) & im(i-1,j) & im(i+1,j) & im(i,j-1) & im(i,j+1);
    end
end

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

subplot(1,3,2);
image(im3*255);
colormap(gray(256));
title('erosion 3 times first');

%% dilation
[m,n] = size(im3);

for i = 2:m-1
    for j = 2:n-1
        im4(i,j) = im3(i,j) | im3(i-1,j) | im3(i+1,j) | im3(i,j-1) | im3(i,j+1);
    end
end

[m,n] = size(im4);
for i = 2:m-1
    for j = 2:n-1
        im5(i,j) = im4(i,j) | im4(i-1,j) | im4(i+1,j) | im4(i,j-1) | im4(i,j+1);
    end
end

[m,n] = size(im5);
for i = 2:m-1
    for j = 2:n-1
        im6(i,j) = im5(i,j) | im5(i-1,j) | im5(i+1,j) | im5(i,j-1) | im5(i,j+1);
    end
end

subplot(1,3,3);
image(im6*255);
colormap(gray(256));
title('then dilation 3 times');