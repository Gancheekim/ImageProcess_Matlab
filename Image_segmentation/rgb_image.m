% segmentaion 1
clear R
clear A
clear B
clear C
clear Z
clear W
%-------RGB image------------
C = double(imread('D:\Users\Lenovo\Desktop\pic\planets_color.bmp'));
% C = double(imread('D:\Users\Lenovo\Pictures\Wallpaper_\hualian_new.jpg'));

threshold = 25;
[M,N,d] = size(C);

for i = 1:3
    R(:,:,i) = zeros(M,N);% to classify which region the current pixel is
    A(:,i) = zeros(1,M+N);% mean of the intensity in the region
end
B = zeros(1,M+N);% total no. of pixel in the region

%%
tic;
for m = 1:M
    for n = 1:N
        %step 2 & 3
        if m == 1
            if n > 1
                q = R(1,n-1,1); % q = left pixel's region group
                diff_R = abs(C(m,n,1) - A(q,1));
                diff_G = abs(C(m,n,2) - A(q,2));
                diff_B = abs(C(m,n,3) - A(q,3));
                diff = (diff_R + diff_G + diff_B)/3;
                if diff > 25 % case 2: diff > 25
                    R(m,n,:) = j+1;
                    for i = 1:3
                        A(j+1,i) = C(m,n,i);
                    end
                    B(j+1) = 1;
                    j = j+1;
                elseif diff <= 25 % case 1: diff <= 25
                    R(m,n,:) = q;
                    for g = 1:3
                        A(q,g) = (A(q,g)*B(q) + C(m,n,g) ) / (B(q)+1);
                    end
                    B(q) = B(q)+1;

                end
            end
            %step 1
            if n == 1
                for i = 1:3
                    R(m,n,i) = 1;
                    B(1) = 1;
                    A(1,i) = C(m,n,i);
                end
                j = 1;
                
            end
%------------------------------------------------------------------------            
        elseif m > 1
            if n == 1 % step 4
                i = R(m-1,1,1);
                diff_R = abs(C(m,n,1) - A(i,1));
                diff_G = abs(C(m,n,2) - A(i,2));
                diff_B = abs(C(m,n,3) - A(i,3));
                diff = (diff_R + diff_G + diff_B)/3;
                if diff <= threshold % case1
                    R(m,n,:) = i;
                    for g = 1:3
                        A(i,g) = (A(i,g)*B(i) + C(m,n,g) ) / (B(i)+1);
                    end
                    B(i) = B(i) + 1;

                elseif diff > threshold % case2
                    R(m,n,:) = j+1;
                    for i = 1:3
                        A(j+1,i) = C(m,n,i);
                    end
                    B(j+1) = 1;
                    j = j+1;

                end
%----------------------------------------------------------------------
            elseif n > 1 % step 5
                i = R(m-1,n); % upper pixel's region
                q = R(m,n-1); % left pixel's region
                
                diff_up_R = abs(C(m,n,1)-A(i,1));
                diff_up_G = abs(C(m,n,2)-A(i,2));
                diff_up_B = abs(C(m,n,3)-A(i,3));
                diff_up = ( diff_up_R + diff_up_G + diff_up_B )/3;
                
                diff_left_R = abs(C(m,n,1)-A(q,1));
                diff_left_G = abs(C(m,n,2)-A(q,2));
                diff_left_B = abs(C(m,n,3)-A(q,3));
                diff_left = ( diff_left_R + diff_left_G + diff_left_B )/3;
                
                %case1
                if diff_up <= threshold && diff_left > threshold
                    R(m,n,:) = i;
                    for g = 1:3
                        A(i,g) = (A(i,g)*B(i) + C(m,n,g) ) / (B(i)+1);
                    end
                    B(i) = B(i) + 1;
                %case2
                elseif diff_up > threshold && diff_left <= threshold
                    R(m,n,:) = q;
                    for g = 1:3
                        A(q,g) = (A(q,g)*B(q) + C(m,n,g) ) / (B(q)+1);
                    end
                    B(q) = B(q)+1;
                %case3
                elseif diff_up > threshold && diff_left > threshold
                    R(m,n,:) = j+1;
                    for i = 1:3
                        A(j+1,i) = C(m,n,i);
                    end
                    B(j+1) = 1;
                    j = j+1;
                %case4
                elseif diff_up <= threshold && diff_left <= threshold
                    if i == q
                        R(m,n,:) = i;
                        for g = 1:3
                            A(i,g) = (A(i,g)*B(i) + C(m,n,g) ) / (B(i)+1);
                        end
                        B(i) = B(i) + 1;
                 
                    else % merge 2 region
                        R(m,n,:) = i;
                        for g = 1:3
                           A(i,g) = (A(i,g)*B(i) + A(q,g)*B(q) + C(m,n,g))/(B(i)+B(q)+1); 
                        end
                        B(i) = B(i) + B(q) + 1;
                        
%                       % left region become upper region
                        R1 = R(1:m,:,:);
                        R1(R1 == q) = i;
                        R(1:m,:,:) = R1;
                        A(q,:) = 0;
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
        Z(m,n,1) = A(R(m,n,1),1);
        Z(m,n,2) = A(R(m,n,2),2);
        Z(m,n,3) = A(R(m,n,3),3);
    end
end

subplot(1,3,1);
image(C/255);
title('original picture');

subplot(1,3,2);
image(Z/255);
title('after segmentation');

%% erosion for too small region
limit_of_smallest_region = 12;

tic;
tobeDelete1 = find(B <= limit_of_smallest_region);

for i = 1:size(tobeDelete1,2)
    if B(tobeDelete1(i)) >= 1
        %delete the region, or do erosion
        temp = tobeDelete1(i); % temp is the region that has to be 'delete'
        [row,column] = find(R == temp);
        
        % find all the points 
        temp_array1 = [];
        temp_array2 = [];
        temp_array3 = [];
        
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
                find_diff1 = abs(A(R(x,y),1)- A(R(x-1,y),1));
                find_diff2 = abs(A(R(x,y),2)- A(R(x-1,y),2));
                find_diff3 = abs(A(R(x,y),3)- A(R(x-1,y),3));
                overall_diff = ( find_diff1 + find_diff2 + find_diff3 )/3;
                if overall_diff > 0
                    temp1 = A(R(x-1,y),1);
                    temp2 = A(R(x-1,y),2);
                    temp3 = A(R(x-1,y),3);
                    temp_array1 = [temp_array1,temp1];
                    temp_array2 = [temp_array2,temp2];
                    temp_array3 = [temp_array3,temp3];
                end
            end

            if (x+1 <= M)
                find_diff1 = abs(A(R(x,y),1)- A(R(x+1,y),1));
                find_diff2 = abs(A(R(x,y),2)- A(R(x+1,y),2));
                find_diff3 = abs(A(R(x,y),3)- A(R(x+1,y),3));
                overall_diff = ( find_diff1 + find_diff2 + find_diff3 )/3;
                if overall_diff > 0
                    temp1 = A(R(x+1,y),1);
                    temp2 = A(R(x+1,y),2);
                    temp3 = A(R(x+1,y),3);
                    temp_array1 = [temp_array1,temp1];
                    temp_array2 = [temp_array2,temp2];
                    temp_array3 = [temp_array3,temp3];
                end
            end

            if (y-1 > 0)
                find_diff1 = abs(A(R(x,y),1)- A(R(x,y-1),1));
                find_diff2 = abs(A(R(x,y),2)- A(R(x,y-1),2));
                find_diff3 = abs(A(R(x,y),3)- A(R(x,y-1),3));
                overall_diff = ( find_diff1 + find_diff2 + find_diff3 )/3;
                if overall_diff > 0
                    temp1 = A(R(x,y-1),1);
                    temp2 = A(R(x,y-1),2);
                    temp3 = A(R(x,y-1),3);
                    temp_array1 = [temp_array1,temp1];
                    temp_array2 = [temp_array2,temp2];
                    temp_array3 = [temp_array3,temp3];
                end
            end

            if (y+1 <= N)
                find_diff1 = abs(A(R(x,y),1)- A(R(x,y+1),1));
                find_diff2 = abs(A(R(x,y),2)- A(R(x,y+1),2));
                find_diff3 = abs(A(R(x,y),3)- A(R(x,y+1),3));
                overall_diff = ( find_diff1 + find_diff2 + find_diff3 )/3;
                if overall_diff > 0
                    temp1 = A(R(x,y+1),1);
                    temp2 = A(R(x,y+1),2);
                    temp3 = A(R(x,y+1),3);
                    temp_array1 = [temp_array1,temp1];
                    temp_array2 = [temp_array2,temp2];
                    temp_array3 = [temp_array3,temp3];
                end
            end
        end
                
        if min(temp_array1 - A(R(x,y),1) ) >= 0
            aim_color1 = min(temp_array1 - A(R(x,y),1)) + A(R(x,y),1);
        elseif min( temp_array1 - A(R(x,y)) ) < 0
            aim_color1 = abs( min( abs(temp_array1 - A(R(x,y),1)) - A(R(x,y),1)));
        end
        
        if min(temp_array2 - A(R(x,y),2) ) >= 0
            aim_color2 = min(temp_array2 - A(R(x,y),2)) + A(R(x,y),2);
        elseif min( temp_array2 - A(R(x,y),2) ) < 0
            aim_color2 = abs( min( abs(temp_array2 - A(R(x,y),2)) - A(R(x,y),2)));
        end
        
        if min(temp_array3 - A(R(x,y),3) ) >= 0
            aim_color3 = min(temp_array3 - A(R(x,y),3)) + A(R(x,y),3);
        elseif min( temp_array3 - A(R(x,y),3) ) < 0
            aim_color3 = abs( min( abs(temp_array3 - A(R(x,y),3)) - A(R(x,y),3)));
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
            A(R(x,y),1) = aim_color1;
            A(R(x,y),2) = aim_color2;
            A(R(x,y),3) = aim_color3;
        end
    end
end
toc;

for m = 1:M
    for n = 1:N
        region = R(m,n);
        for i = 1:3
            W(m,n,i) = A(R(m,n),i);
        end
    end
end
subplot(1,3,3);
image(W/255);
title('after trial of delete small region');
