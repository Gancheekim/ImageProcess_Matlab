%% harris corner detection

I = double(imread('D:\Users\Lenovo\Desktop\pic\28.gif'));

[a,b] = size(I);

% step 1
X = conv2(I,[-1,-2,-3,-4,0,4,3,2,1],'same');
Y = conv2(I,[-1,-2,-3,-4,0,4,3,2,1]','same');

% step 2
u_mat = -15:15;
v_mat = -15:15;
sigma = 3;
w = zeros(31,31);

tic;
for u = 1:31
    for v = 1:31
        w(u,v) = exp(-(u_mat(u)^2+v_mat(v)^2)/(2*(sigma^2)));
    end
end
toc;
disp('above is the time for w calculation');

A = conv2(X.^2,w,'same');
B = conv2(Y.^2,w,'same');
C = conv2(X.*Y,w,'same');

% step 3
k = 0.04;
R = A.*B - C.^2 - k*((A + B).^2);

% step 4
t = -1:1;
p = -1:1;

L = zeros(a,b);
threshold = max(max(R))/100;
tr=0.01;
for m = 2:a-1
    for n = 2:b-1
        if (R(m,n) > threshold) && (sum(sum((R(m,n) > (R(m+t,n+p)+tr))))/8 == 1)
            L(m,n) = R(m,n);
        end
    end
end 

[fx,fy] = find(L');

imshow(I/255);
hold on;
plot(fx,fy,'*');
hold off;


