%% laplacian operator
im=double(imread('D:\Users\Lenovo\Desktop\pic\Pepper.bmp'));
subplot(1,2,1);
image(im);
colormap(gray(256));
%% start
C = 1;

laplacian = [-1 -1 -1; -1 8 -1,; -1 -1 -1]/8;
im1 = zeros(256-3,256-3);

for i = 1:(256-2)
    for j = 1: (256-2)
        square = im(i:i+2, j:j+2);
        temp = square .* laplacian;
        im1(i,j) = sum(sum(temp));
    end
end

subplot(1,2,2);
image(C*abs(im1));
colormap(gray(256));
title('laplacian');