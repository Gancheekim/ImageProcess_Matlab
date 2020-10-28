%% sobel operator
im=double(imread('D:\Users\Lenovo\Desktop\pic\Lena_gray_512.bmp'));
image(im);
colormap(gray(256));

C = 3;
%% horizontal
sobelx = [1 0 -1; 2 0 -2; 1 0 -1]/4;
im1 = zeros(256-3,256-3);

for i = 1:(512-2)
    for j = 1: (256-2)
        square = im(i:i+2, j:j+2);
        temp = square .* sobelx;
        im1(i,j) = sum(sum(temp));
    end
end

subplot(2,3,1)
image(C*abs(im1));
colormap(gray(256));
title('horizontal');
%% vertical
sobely = [1 2 1; 0 0 0; -1 -2 -1]/4;
im2 = zeros(512-3,512-3);

for i = 1:(512-2)
    for j = 1: (512-2)
        square = im(i:i+2, j:j+2);
        temp = square .* sobely;
        im2(i,j) = sum(sum(temp));
    end
end

subplot(2,3,2)
image(C*abs(im2));
colormap(gray(256));
title('vertical');
%% overall( with (x^2 + y^2)^(1/2) )

im_out = (im1.^2 + im2.^2).^(1/2);
test = im1 + im2;

subplot(2,3,3)
image(C*abs(im_out));
colormap(gray(256));
title('overall for hor and ver');
%% 45 degree
sobel_45 = [0 -1 -2; 1 0 -1; 2 1 0]/4;
im2 = zeros(256-3,256-3);

for i = 1:(256-2)
    for j = 1: (256-2)
        square = im(i:i+2, j:j+2);
        temp = square .* sobel_45;
        im_45(i,j) = sum(sum(temp));
    end
end

subplot(2,3,4)
image(C*abs(im_45));
colormap(gray(256));
title('45 degree');
%% 135 degree
sobel_135 = [-2 -1 0; -1 0 1; 0 1 2]/4;
im_135 = zeros(256-3,256-3);

for i = 1:(256-2)
    for j = 1: (256-2)
        square = im(i:i+2, j:j+2);
        temp = square .* sobel_135;
        im_135(i,j) = sum(sum(temp));
    end
end

subplot(2,3,5)
image(C*abs(im_135));
colormap(gray(256));
title('135 degree');
%% overall for 45 and 135

im_out2 = ((im_45).^2 + (im_135).^2).^(1/2) ;
subplot(2,3,6);
image(C*abs(im_out2));
colormap(gray(256));
title('overall for 45 and 135');