p1=[2,-1,3];
p2=[-1,3,5];
p3=[0,2,4];
p4=[4,-2,-1];
p5=[1,0,4];
p6=[-2,5,5];

% mean
mx = (2 -1 +4+1-2)/6;
my = (-1+3+2-2+5)/6;
mz = (3+5+4-1+4+5)/6;

mean = [mx,my,mz];

A = zeros(6,3);

A(1,:) = p1 - mean;
A(2,:) = p2 - mean;
A(3,:) = p3 - mean;
A(4,:) = p4 - mean;
A(5,:) = p5 - mean;
A(6,:) = p6 - mean;

[U,S,V] = svd(A);

v1 = V(:,1)';
um = U(:,1);
lambda1 = S(1,1);

% plotting the PCA
x = -5:0.1:5;
y = -5:0.1:5;
z = -5:0.1:5;

[X,Y] = meshgrid(x,y);
Z = (v1(1)*X + v1(2)*Y)/v1(3);

subplot(1,2,1);
surf(X+mx,Y+my,Z+mz);

% plotting points of data
points = [p1;p2;p3;p4;p5;p6];
subplot(1,2,2);
plot3(points(:,1),points(:,2),points(:,3),'o');
grid on;