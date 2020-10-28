%% color intensity
im=double(imread('D:\Users\Lenovo\Desktop\pic\airplane.bmp'));
subplot(2,2,3);
image(im/255);
title('original picture');

%% black white
bw = double(imread('D:\Users\Lenovo\Desktop\pic\1.gif'));
subplot(2,2,1);
imshow(bw/255);
title('blackwhite orignal picture');

a = 1;
Fy = 255*(bw/255).^a;

subplot(2,2,2);
image(Fy);
colormap(gray(256));
title('darken/lighten blackwhite picture');

%% RGB to YCbCr
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

Y = 0.299*R + 0.587*G + 0.114*B;
Cb = -0.169*R - 0.331*G + 0.5*B;
Cr = 0.5*R -0.419*G -0.081*B;

b = 3;

Y_new = 255*(Y/255).^b;

R_new = 1*Y_new + 1.402*Cr;
G_new = 1*Y_new - 0.344136*Cb - 0.714136*Cr; 
B_new = 1*Y_new + 1.772*Cb;

im2 = zeros(512,512,3);
im2(:,:,1) = R_new;
im2(:,:,2) = G_new;
im2(:,:,3) = B_new;

subplot(2,2,4);
image(im2/255);
title('RGB lighten/darken');
