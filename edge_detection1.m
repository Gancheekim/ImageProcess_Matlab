im=double(imread('D:\Users\Lenovo\Desktop\pic\Pepper.bmp'));
image(im);
colormap(gray(256));
subplot(2,2,1);
imshow(im/255);
C = 1;
%% edge detection
% difference

% horizontal
hor = zeros(256,256);

n=1;
while n < 256
    hor(:,n) = im(:,n+1) - im(:,n);
    n = n+1;
end
subplot(2,2,2);
image(C*abs(hor));
colormap(gray(256));
%% vertical
ver = zeros(256,256);

m=1;
while m < 256
    ver(m,:) = im(m+1,:) - im(m,:);
    m = m+1;
end

subplot(2,2,3);
image(C*abs(ver));
colormap(gray(256));
%% overall
overall = zeros(256,256);
x = hor.^2;
y = ver.^2;

overall = (x + y).^(1/2);

subplot(2,2,4);
image(C*real(abs(overall)));
