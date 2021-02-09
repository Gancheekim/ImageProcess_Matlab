%%
im=double(imread('D:\Users\Lenovo\Desktop\pic\bmp\lena.bmp'));
subplot(2,3,1);
image(im);
colormap(gray(256));

%% erosion
[m,n] = size(im);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im(i,j);
        temp2 = im(i-1,j);
        temp3 = im(i+1,j);
        temp4 = im(i,j-1);
        temp5 = im(i,j+1);
        temp_array = [temp1,temp2,temp3,temp4,temp5];
        im1(i,j) = min(temp_array);
    end
end

subplot(2,3,2);
image(im1);
colormap(gray(256));
title('erosion 1 time');

[m,n] = size(im1);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im1(i,j);
        temp2 = im1(i-1,j);
        temp3 = im1(i+1,j);
        temp4 = im1(i,j-1);
        temp5 = im1(i,j+1);
        temp_array = [temp1,temp2,temp3,temp4,temp5];
        im2(i,j) = min(temp_array);
    end
end

[m,n] = size(im2);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im2(i,j);
        temp2 = im2(i-1,j);
        temp3 = im2(i+1,j);
        temp4 = im2(i,j-1);
        temp5 = im2(i,j+1);
        temp_array= [temp1,temp2,temp3,temp4,temp5];
        im3(i,j) = min(temp_array);
    end
end

subplot(2,3,3);
image(im3);
colormap(gray(256));
title('erosion 3 times');

%% dilation
subplot(2,3,4);
image(im);

[m,n] = size(im);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im(i,j);
        temp2 = im(i-1,j);
        temp3 = im(i+1,j);
        temp4 = im(i,j-1);
        temp5 = im(i,j+1);
        temp_array = [temp1,temp2,temp3,temp4,temp5];
        im4(i,j) = max(temp_array);
    end
end

subplot(2,3,5);
image(im4);
colormap(gray(256));
title('dilation 1 time');

[m,n] = size(im1);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im4(i,j);
        temp2 = im4(i-1,j);
        temp3 = im4(i+1,j);
        temp4 = im4(i,j-1);
        temp5 = im4(i,j+1);
        temp_array = [temp1,temp2,temp3,temp4,temp5];
        im5(i,j) = max(temp_array);
    end
end

[m,n] = size(im5);

for i = 2:m-1
    for j = 2:n-1
        temp1 = im5(i,j);
        temp2 = im5(i-1,j);
        temp3 = im5(i+1,j);
        temp4 = im5(i,j-1);
        temp5 = im5(i,j+1);
        temp_array= [temp1,temp2,temp3,temp4,temp5];
        im6(i,j) = max(temp_array);
    end
end

subplot(2,3,6);
image(im6);
colormap(gray(256));
title('dilation 3 times');