% segmentaion 1
clear all
%-----binary test----------
%C = 255*double(imread('D:\Users\Lenovo\Desktop\pic\bowtest.bmp'));
%C = 255*double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (2).gif'));
%C = 255*double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (5).gif'));
%C = 255*double(imread('D:\Users\Lenovo\Desktop\pic\binary_img\binary (22).gif'));

%------non binary test--------
%C = double(imread('D:\Users\Lenovo\Desktop\pic\flag.bmp'));
%C = double(imread('D:\Users\Lenovo\Desktop\pic\IMG00g.bmp'));
%C = double(imread('D:\Users\Lenovo\Desktop\pic\beach.jpg'));
% C = double(imread('D:\Users\Lenovo\Desktop\pic\LENA.bmp'));

C = double(imread('D:\Users\Lenovo\Pictures\Wallpaper_\hualian_new.jpg'));
C = (C(:,:,1) + C(:,:,2) + C(:,:,3))/3;


threshold = 22;
[M,N] = size(C);

R = zeros(M,N); % to classify which region the current pixel is
A = zeros(1,M+N); % mean of the intensity in the region
B = zeros(1,M+N); % total no. of pixel in the region

tic;
for m = 1:M
    for n = 1:N
        %step 2 & 3
        if m == 1
            if n > 1
                q = R(1,n-1); % q = left pixel's region group
                diff = abs(C(m,n) - A(q));
                if diff > threshold % case 2: diff > 25
                    R(m,n) = j+1;
                    A(j+1) = C(m,n);
                    B(j+1) = 1;
                    j = j+1;
                elseif diff <= threshold % case 1: diff <= 25
                    R(m,n) = q;
                    A(q) = (A(q)*B(q) + C(m,n)) / (B(q)+1);
                    B(q) = B(q)+1;

                end
            end
            %step 1
            if n == 1
                R(1,1) = 1;
                B(1) = 1;
                A(1) = C(1,1);
                j = 1;
                
            end
%------------------------------------------------------------------------            
        elseif m > 1
            if n == 1 % step 4
                i = R(m-1,1);
                diff = abs(C(m,n)-A(i));
                if diff <= threshold % case1
                    R(m,n) = i;
                    A(i) = (A(i)*B(i) + C(m,n)) / (B(i)+1);
                    B(i) = B(i) + 1;

                elseif diff > threshold % case2
                    R(m,n) = j+1;
                    A(j+1) = C(m,n);
                    B(j+1) = 1;
                    j = j+1;

                end
%----------------------------------------------------------------------
            elseif n > 1 % step 5
                i = R(m-1,n); % upper pixel's region
                q = R(m,n-1); % left pixel's region
                diff_up = abs(C(m,n)-A(i));
                diff_left = abs(C(m,n)-A(q));
                
                %case1
                if diff_up <= threshold && diff_left > threshold
                    R(m,n) = i;
                    A(i) = (A(i)*B(i) + C(m,n)) / (B(i)+1);
                    B(i) = B(i) + 1;
                %case2
                elseif diff_up > threshold && diff_left <= threshold
                    R(m,n) = q;
                    A(q) = (A(q)*B(q) + C(m,n)) / (B(q)+1);
                    B(q) = B(q)+1;
                %case3
                elseif diff_up > threshold && diff_left > threshold
                    R(m,n) = j+1;
                    A(j+1) = C(m,n);
                    B(j+1) = 1;
                    j = j+1;
                %case4
                elseif diff_up <= threshold && diff_left <= threshold
                    if i == q
                        R(m,n) = i;
                        A(i) = (A(i)*B(i) +C(m,n))/(B(i)+1);
                        B(i) = B(i) + 1;
                 
                    else % merge 2 region
                        R(m,n) = i;
                        A(i) = (A(i)*B(i) + A(q)*B(q) + C(m,n)) / (B(i)+B(q)+1);
                        B(i) = B(i) + B(q) + 1;
                        
%                       % left region become upper region
                        R1 = R(1:m,:);
                        R1(R1 == q) = i;
                        R(1:m,:) = R1;
                        A(q) = 0;
                        B(q) = 0;
                        
                    end
                end
            end
        end
    end
end
toc;

%%
for m = 1:M
    for n = 1:N
        region = R(m,n);
        Z(m,n) = A(region);
    end
end

subplot(1,3,1);
image(C);
title('original picture');

subplot(1,3,2);
image(Z);
colormap(gray(256));
title('after segmentation');

% for more binary picture(a picture that is less detail), threshold can set
% to be smaller.
%
% for the more detailed picture, if threshold is too small, segmentation lost
% its purpose.
%
%% erosion for too small region
limit_of_smallest_region = 10;

tic;
tobeDelete1 = find(B <= limit_of_smallest_region);

for i = 1:size(tobeDelete1,2)
    if B(tobeDelete1(i)) >= 1
        %delete the region, or do erosion
        temp = tobeDelete1(i); % temp is the region that has to be 'delete'
        [row,column] = find(R == temp);
        
        % find all the points 
        temp_array = [];
        
        for temptemp = 1:size(row,2)
            x = row(temptemp);
            if x == 0
                x = M;
            end
            y = column(temptemp);
            if y == 0
                y = N;
            end
                       
            if (x-1 > 0)
                if abs(A(R(x,y))- A(R(x-1,y))) > 0
                    temp1 = A(R(x-1,y));
                    temp_array = [temp_array,temp1];
                end
            end

            if (x+1 <= M)
                if abs(A(R(x,y))- A(R(x+1,y))) > 0
                    temp1 = A(R(x+1,y));
                    temp_array = [temp_array,temp1];
                end
            end

            if (y-1 > 0)
                if abs(A(R(x,y))- A(R(x,y-1))) > 0
                    temp1 = A(R(x,y-1));
                    temp_array = [temp_array,temp1];
                end
            end

            if (y+1 <= N)
                if abs(A(R(x,y))- A(R(x,y+1))) > 0
                    temp1 = A(R(x,y+1));
                    temp_array = [temp_array,temp1];
                end
            end
        end
                
        if min(temp_array - A(R(x,y)) ) > 0
            aim_color = min(temp_array - A(R(x,y))) + A(R(x,y));
        elseif min( temp_array - A(R(x,y)) ) < 0
            aim_color = abs( min( abs(temp_array - A(R(x,y))) - A(R(x,y))));
        end
        
        for temptemp = 1:size(row,2)
            x = row(temptemp);
            if x == 0
                x = M;
            end
            y = column(temptemp);
            if y == 0
                y = N;
            end
            A(R(x,y)) = aim_color;
        end
    end
end
toc;

for m = 1:M
    for n = 1:N
        region = R(m,n);
        W(m,n) = A(region);
    end
end
subplot(1,3,3);
image(W);
colormap(gray(256));
title('after trial of delete small region');