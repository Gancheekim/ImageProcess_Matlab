%% affine transformer
A = double(imread('Lena_gray_512.bmp'));
[temp1,temp2] = size(A);

B = zeros(temp1,temp2);
[sizex,sizey] = size(B);

% 1 = scaling, 2 = rotation, 3 = reflection, 4 = shearing
choose = 4;
angle = pi/6; % change for  rotation

if (choose == 1)
    a = 0.7; % scale of x axis
    b = 0;
    c = 0;
    d = 0.7; % scale of y axis
elseif (choose == 2)
    a = cos(angle);
    b = -sin(angle);
    c = sin(angle);
    d = cos(angle);
elseif (choose == 3)
    a = -1; % 1/-1
    b = 0;
    c = 0;
    d = -1; % 1/-1
elseif (choose == 4)
    a = 1;
    b = 0; % change in vertical
    c = 0.4; % change in horizontal
    d = 1;
    clear B;
    B = zeros(temp1 + 100 ,temp2 + 100); % change for diff size image
    [sizex,sizey] = size(B);
end

% set center of proccessed image:
m0 = sizex/2;
n0 = sizey/2;
mm=temp1/2;
nn=temp2/2;

detA = a*d - b*c;
for m = 1:sizex
    for n = 1:sizey
        m1 = (d/detA)*(m-m0) - (b/detA)*(n-n0) + mm;
        n1 = (-c/detA)*(m-m0) + (a/detA)*(n-n0) + nn;
        if (m1 < 1) || (m1 > temp1) || (n1 < 1) || (n1 > temp2)
            B(m,n) = 0;
        else
            B(m,n) = A(round(m1) , round(n1));
        end
    end
end

imshow(B/255);
        